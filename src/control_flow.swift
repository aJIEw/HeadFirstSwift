print("===================== For-In Loops =====================")
// closed range operator
for index in 1...3 {
    print("\(index) times 5 is \(index * 5)")
}

// half-open range operator
for tick in 1..<3 {
    print("count to \(tick)")
}

// stride(from:through/to:by:) function
for tick in stride(from: 3, through: 12, by: 3) {
    print("upgrade to \(tick)")
}


print("===================== While Loops =====================")
var gameRound = 1
while gameRound <= 3 {
    print("Playing round \(gameRound)")
    gameRound += 1
}
print("Game over")

let daysInWeek = 5
var workingDays = 0
repeat {
    print("Day \(workingDays + 1): Today you're going to work")
    workingDays += 1
} while workingDays < daysInWeek


print("===================== Switch =====================")
let someCharacter: Character = "a"
switch someCharacter {
case "a", "A":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

// Using Interval Matching
let approximateCount = 62
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("result = \(naturalCount)")

// Using Tuples
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

// Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x > 0 && y > 0:
    print("(\(x), \(y)) is on the first quadrant")
case let (x, y) where x < 0 && y > 0:
    print("(\(x), \(y)) is on the second quadrant")
case let (x, y) where x < 0 && y < 0:
    print("(\(x), \(y)) is on the third quadrant")
case let (x, y) where x > 0 && y < 0:
    print("(\(x), \(y)) is on the fourth quadrant")
case let (x, y) where x == 0 || y == 0:
    print("(\(x), \(y)) is on the x-axis or y-axis")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// Compound cases with value bindings
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// fallthrough keyword, default disabled
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description
)
