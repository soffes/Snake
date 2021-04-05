struct SnakeGame {

	// MARK: - Types

	enum Thing {
		case empty
		case snakeHead
		case snakeBody
		case snakeTail
		case fruit

		var isSnake: Bool {
			switch self {
			case .snakeHead, .snakeBody, .snakeTail:
				return true
			default:
				return false
			}
		}
	}

	enum Direction {
		case north
		case east
		case south
		case west
	}

	// MARK: - Properties

	private(set) var matrix: Matrix<Thing>
	private var position: Coordinate

	// MARK: - Initializers

	init(width: Int, height: Int) {
		matrix = Matrix(rows: height, columns: width, defaultValue: Thing.empty)
		position = Coordinate(x: width / 2, y: height / 2)
		matrix[position] = .snakeHead
	}

	// MARK: - Movement

	mutating func move(_ direction: Direction) {
		matrix[position] = .empty

		switch direction {
		case .north:
			position.y = max(0, position.y - 1)

		case .east:
			position.x = min(matrix.numberOfColumns - 1, position.x + 1)

		case .south:
			position.y = min(matrix.numberOfRows - 1, position.y + 1)

		case .west:
			position.x = max(0, position.x - 1)
		}

		matrix[position] = .snakeHead
	}
}