enum CompassPoint: CaseIterable {
    case north, south, east, west
}

var direction = CompassPoint.north
print("direction -> \(direction)")
direction = .west
print("direction -> \(direction)")

switch direction {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

print("There're \(CompassPoint.allCases.count) directions, and they are:")
for direction in CompassPoint.allCases {
    print(direction)
}