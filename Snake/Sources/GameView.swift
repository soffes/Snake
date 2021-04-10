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

	@State var game = SnakeGame(width: 15, height: 15)

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

			Text("Score: \(game.score)")

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

				Button("Tick") {
					game.tick()
				}
			}
		}.padding(16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
