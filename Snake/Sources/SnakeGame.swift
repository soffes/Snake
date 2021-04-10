struct SnakeGame {

	// MARK: - Types

	enum State {
		case playing
		case dead
	}

	enum Thing {
		case empty
		case snakeHead
		case snakeBody
		case fruit
	}

	// MARK: - Properties

	var state: State = .playing

	private(set) var matrix: Matrix<Thing>
	private(set) var score = 0

	private var currentDirection: Direction = .west

	/// Snake coordinates. `first` is the head and `last` is the tail
	var snakeCoordinates = [Coordinate]() {
		willSet {
			snakeCoordinates.forEach { matrix[$0] = .empty }
		}

		didSet {
			snakeCoordinates.forEach { matrix[$0] = .snakeBody }
			matrix[snakeCoordinates[0]] = .snakeHead
		}
	}

	// MARK: - Initializers

	init(width: Int, height: Int) {
		matrix = Matrix(rows: height, columns: width, defaultValue: Thing.empty)
		restart()
	}

	// MARK: - Manipulation

	mutating func tick() {
		guard state == .playing else {
			return
		}

		moveSnake(currentDirection)
	}

	mutating func changeDirection(_ direction: Direction) {
		currentDirection = direction
	}

	mutating func restart() {
		matrix.reset()

		let head = Coordinate(x: matrix.numberOfColumns / 2, y: matrix.numberOfRows / 2)
		let body1 = head.neighbor(in: .east)
		let body2 = body1.neighbor(in: .east)
		snakeCoordinates = [head, body1, body2]

		generateFruit()
		score = 0
		state = .playing
	}

	// MARK: - Private

	private mutating func moveSnake(_ direction: Direction) {
		guard let head = snakeCoordinates.first else {
			assertionFailure("Missing snake extremities")
			return
		}

		// Find next head position
		let newHead = head.neighbor(in: currentDirection)

		// Check if new head is in bounds
		if !matrix.inBounds(newHead) {
			die()
			return
		}

		// Check collisions
		let foundFruit: Bool
		switch matrix[newHead] {
		case .fruit:
			score += 1
			foundFruit = true
		case .snakeBody, .snakeHead:
			die()
			return
		case .empty:
			foundFruit = false
		}

		// Remove tail snake if we aren’t growing
		if !foundFruit {
			snakeCoordinates.removeLast()
		}

		// Move head
		snakeCoordinates.insert(newHead, at: 0)

		// Generate more fruit
		if foundFruit {
			generateFruit()
		}
	}

	private mutating func generateFruit() {
		let coordinate = Coordinate(x: Int.random(in: 0..<matrix.numberOfColumns),
									y: Int.random(in: 0..<matrix.numberOfRows))

		if matrix[coordinate] != .empty {
			generateFruit()
			return
		}

		matrix[coordinate] = .fruit
	}

	private mutating func die() {
		state = .dead
	}
}
