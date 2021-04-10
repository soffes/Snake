enum Direction {
	case north
	case east
	case south
	case west

	var opposite: Direction {
		switch self {
		case .north:
			return .south
		case .east:
			return .west
		case .south:
			return .north
		case .west:
			return .east
		}
	}
}
