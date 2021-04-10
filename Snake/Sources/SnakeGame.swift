struct SnakeGame {

	// MARK: - Types

	enum Thing {
		case empty
		case snakeHead
		case snakeBody
		case fruit
	}

	// MARK: - Properties

	private(set) var matrix: Matrix<Thing>
	private(set) var score = 0

	private var currentDirection: Direction = .west

	/// Snake coordinates. `first` is the head and `last` is the tail
	var snakeCoordinates: [Coordinate] {
		willSet {
			snakeCoordinates.forEach { matrix[$0] = .empty }
		}

		didSet {
			updateSnakeCells()
		}
	}

	// MARK: - Initializers

	init(width: Int, height: Int) {
		matrix = Matrix(rows: height, columns: width, defaultValue: Thing.empty)

		let head = Coordinate(x: width / 2, y: height / 2)
		let body = head.neighbor(in: .east)
		snakeCoordinates = [head, body]

		updateSnakeCells()
		generateFruit()
	}

	// MARK: - Manipulation

	mutating func tick() {
		moveSnake(currentDirection)

		// Check for collisions with either fruit, snake, or wall

		// If fruit, increase score, grow snake, and spawn new fruit
	}

	mutating func changeDirection(_ direction: Direction) {
		currentDirection = direction
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

	private func die() {
		print("you're dead")
	}

	private mutating func updateSnakeCells() {
		snakeCoordinates.forEach { matrix[$0] = .snakeBody }
		matrix[snakeCoordinates[0]] = .snakeHead
	}
}
