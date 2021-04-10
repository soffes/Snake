struct Coordinate {
	var x: Int
	var y: Int

	func neighbor(in direction: Direction) -> Coordinate {
		var coordinate = self

		switch direction {
		case .north:
			coordinate.y -= 1
		case .east:
			coordinate.x += 1
		case .south:
			coordinate.y += 1
		case .west:
			coordinate.x -= 1
		}

		return coordinate
	}
}
