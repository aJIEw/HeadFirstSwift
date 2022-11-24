enum CompassPoint: CaseIterable {
    case north, south, east, west

    mutating func changeDirection(_ newDirection: CompassPoint) {
        self = newDirection
    }
}

var direction = CompassPoint.north
print("direction -> \(direction)")
direction = .west
direction.changeDirection(.east)
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


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune

    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

print("Earth is No.\(Planet.earth.rawValue) in the solar system.")
var mars = Planet[4]
print(mars)