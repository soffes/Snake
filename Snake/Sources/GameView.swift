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

	private let timer = Timer.publish(every: 1 / 3, on: .main, in: .common).autoconnect()

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

			HStack {
				Button("↑") {
					game.changeDirection(.north)
				}.keyboardShortcut(.upArrow)

				Button("→") {
					game.changeDirection(.east)
				}.keyboardShortcut(.rightArrow)

				Button("↓") {
					game.changeDirection(.south)
				}.keyboardShortcut(.downArrow)

				Button("←") {
					game.changeDirection(.west)
				}.keyboardShortcut(.leftArrow)
			}
		}
		.padding(16)
		.onReceive(timer) { _ in
			game.tick()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
