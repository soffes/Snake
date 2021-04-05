import SwiftUI

struct ContentView: View {

	let matrix: Matrix<Bool> = {
		var matrix = Matrix(rows: 15, columns: 15, defaultValue: false)
		matrix[1, 3] = true
		matrix[2, 4] = true
		matrix[3, 5] = true
		return matrix
	}()

    var body: some View {
		VStack {
			ForEach(matrix.rows) { row in
				HStack {
					ForEach(matrix.cells(inRow: row.index)) { cell in
						Toggle(isOn: .constant(cell.element), label: {
							Text("")
						})
					}
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
