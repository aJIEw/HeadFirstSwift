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

// associated with values
enum ListType {
    case vertical(Int)
    case horizontal(Int, String)
}

var listType: ListType = .horizontal(2, "pageId")
// extract them with switch
switch(listType) {
case .vertical(let column):
    print("It's a vertical list with \(column) columns")
case let .horizontal(row, id):
    print("It's a horizontal list with \(row) rows, id = \(id)")
default:
    print("Unknow type")
}