struct Matrix<Element> {

	// MARK: - Types

	typealias Coordinate = (Int, Int)

	struct Row: Identifiable {
		var index: Int

		var id: String {
			"Row \(index)"
		}
	}

	struct Cell<Element>: Identifiable {
		var coordinate: Coordinate
		var element: Element

		var id: String {
			"Cell \(coordinate.0),\(coordinate.1)"
		}
	}

	// MARK: - Properties

	let numberOfRows: Int
	let numberOfColumns: Int

	var rows: [Row] {
		(0..<numberOfRows).map(Row.init)
	}

	/// Array of rows
	private var elements: [[Element]]

	// MARK: - Initializers

	init(rows: Int, columns: Int, defaultValue: Element) {
		elements = Array(repeating: Array(repeating: defaultValue, count: rows), count: columns)
		numberOfRows = rows
		numberOfColumns = columns
	}

	// MARK: - Subscript

	subscript(_ x: Int, _ y: Int) -> Element {
		get {
			elements[x][y]
		}

		set(newValue) {
			elements[x][y] = newValue
		}
	}

	// MARK: - Accessing Elements

	func cells(inRow y: Int) -> [Cell<Element>] {
		elements[y].enumerated().map { x, element in
			Cell(coordinate: (x, y), element: element)
		}
	}
}
