import SwiftUI

struct ContentView: View {

	@State var game = SnakeGame(width: 15, height: 15)

    var body: some View {
		VStack {
			ForEach(game.matrix.rows) { row in
				HStack {
					ForEach(game.matrix.cells(inRow: row.index)) { cell in
						Toggle(isOn: .constant(cell.element == .snakeHead), label: {
							Text("")
						})
					}
				}
			}

			HStack {
				Button("↑") {
					game.move(.north)
				}.keyboardShortcut(.upArrow)

				Button("→") {
					game.move(.east)
				}.keyboardShortcut(.rightArrow)

				Button("↓") {
					game.move(.south)
				}.keyboardShortcut(.downArrow)

				Button("←") {
					game.move(.west)
				}.keyboardShortcut(.leftArrow)
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
