struct SnakeGame {

	// MARK: - Types

	enum Thing {
		case empty
		case snake
		case fruit
	}

	// MARK: - Properties

	private(set) var matrix: Matrix<Thing>
	private(set) var score = 0

	private var currentDirection: Direction = .west

	/// Snake coordinates. `first` is the head and `last` is the tail
	var snakeCoordinates: [Coordinate]

	// MARK: - Initializers

	init(width: Int, height: Int) {
		matrix = Matrix(rows: height, columns: width, defaultValue: Thing.empty)

		let center = Coordinate(x: width / 2, y: height / 2)
		snakeCoordinates = [center, Coordinate(x: center.x + 1, y: center.y)]
		snakeCoordinates.forEach { matrix[$0] = .snake }

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
		var newHead = head
		switch currentDirection {
		case .north:
			newHead.y -= 1
		case .east:
			newHead.x += 1
		case .south:
			newHead.y += 1
		case .west:
			newHead.x -= 1
		}

		// Check if new head is in bounds
		if !inBounds(newHead) {
			die()
			return
		}

		// Check collisions
		let foundFruit: Bool
		switch matrix[newHead] {
		case .fruit:
			score += 1
			foundFruit = true
		case .snake:
			die()
			return
		case .empty:
			foundFruit = false
		}

		// Remove tail snake
		if !foundFruit {
			guard let tail = snakeCoordinates.popLast() else {
				assertionFailure("Missing snake tail")
				return
			}

			matrix[tail] = .empty
		}

		// Move head
		snakeCoordinates.insert(newHead, at: 0)
		matrix[newHead] = .snake

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

	private func inBounds(_ coordinate: Coordinate) -> Bool {
		coordinate.x >= 0 && coordinate.y >= 0 && coordinate.x < matrix.numberOfColumns &&
			coordinate.y < matrix.numberOfRows
	}

	private func die() {
		print("you're dead")
	}
}
