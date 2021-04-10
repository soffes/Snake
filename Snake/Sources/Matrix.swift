struct Matrix<Element> {

	// MARK: - Types

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
			"Cell \(coordinate.x),\(coordinate.y)"
		}
	}

	// MARK: - Properties

	let numberOfRows: Int
	let numberOfColumns: Int
	private let defaultValue: Element

	var rows: [Row] {
		(0..<numberOfRows).map(Row.init)
	}

	/// Array of rows
	private var elements: [[Element]]

	// MARK: - Initializers

	init(rows numberOfRows: Int, columns numberOfColumns: Int, defaultValue: Element) {
		self.defaultValue = defaultValue
		self.numberOfRows = numberOfRows
		self.numberOfColumns = numberOfColumns
		elements = Array(repeating: Array(repeating: defaultValue, count: numberOfRows), count: numberOfColumns)
	}

	// MARK: - Subscript

	subscript(_ coordinate: Coordinate) -> Element {
		get {
			self[coordinate.x, coordinate.y]
		}

		set(newValue) {
			self[coordinate.x, coordinate.y] = newValue
		}
	}

	subscript(_ x: Int, y: Int) -> Element {
		get {
			elements[y][x]
		}

		set(newValue) {
			elements[y][x] = newValue
		}
	}

	// MARK: - Bounds Checking

	func inBounds(_ coordinate: Coordinate) -> Bool {
		coordinate.x >= 0 && coordinate.y >= 0 && coordinate.x < numberOfColumns && coordinate.y < numberOfRows
	}

	// MARK: - Accessing Elements

	func cells(inRow y: Int) -> [Cell<Element>] {
		elements[y].enumerated().map { x, element in
			Cell(coordinate: Coordinate(x: x, y: y), element: element)
		}
	}

	// MARK: - Resetting

	mutating func reset() {
		elements = Array(repeating: Array(repeating: defaultValue, count: numberOfRows), count: numberOfColumns)
	}
}
