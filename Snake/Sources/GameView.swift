import AppKit
import SwiftUI

extension SnakeGame.Thing {
	var color: Color? {
		switch self {
		case .empty:
			return nil

		case .snakeHead:
			return Color.green

		case .snakeBody:
			return Color(red: 0, green: 0.33, blue: 0)

		case .fruit:
			return Color.red
		}
	}
}

struct GameView: View {

	// MARK: - Properties

	@State var game = SnakeGame(width: 15, height: 15)

	private let timer = Timer.publish(every: 1 / 4, on: .main, in: .common).autoconnect()

	// MARK: - View

    var body: some View {
		VStack {
			ForEach(game.matrix.rows) { row in
				HStack {
					ForEach(game.matrix.cells(inRow: row.index)) { cell in
						Toggle(isOn: .constant(cell.element != .empty), label: {
							Text("")
						}).accentColor(cell.element.color)
					}
				}
			}

			switch game.state {
			case .playing:
				Text("Score: \(game.score)")
			case .dead:
				HStack {
					Text("Score: \(game.score) — Game Over")

					Button("New Game") {
						game.restart()
					}
				}
			}
		}
		.padding(16)
		.onReceive(timer) { _ in
			game.tick()
		}
		.background(KeyEventHandling() { event in
			handleKeyboardEvent(event)
		})
    }

	// MARK: - Private

	private func handleKeyboardEvent(_ event: NSEvent) {
		switch event.keyCode {
		// Left arrow
		case 123:
			game.changeDirection(.west)

		// Right arrow
		case 124:
			game.changeDirection(.east)

		// Down arrow
		case 125:
			game.changeDirection(.south)

		// Up arrow
		case 126:
			game.changeDirection(.north)

		default:
			break
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
