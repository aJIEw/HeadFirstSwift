func greeting(name: String) -> String {
    return "Hi \(name)!"
}
print(greeting(name: "Swift"))

// use underscore _ to ommit arguemnt label
func greeting(_ name: String, from: String) {
   print("Hi \(name), from \(from).")
}
greeting("Swift", from: "Apple")
greeting("Dart", from: "Google")
greeting("Kotlin", from: "JetBrains")

// implicit return & default parameter
func getMessage(_ message: String = "Empty message") -> String {
    "Received is a message: \(message)"
}
print(getMessage())
print(getMessage("Calling from space..."))

// variadic parameters
func getTotalNumber(_ numbers: Int...) -> Int {
    var sum = 0
    for num in numbers {
      sum += num
    }
    return sum
}
var totalNumber = getTotalNumber(1, 2, 3)
print("total number = \(totalNumber)")


// inout parameters
print("===================== inout parameter =====================")
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var numOne = 1
var numTwo = 2
print("before:\nnumOne = \(numOne), numTwo = \(numTwo)")
swapTwoInts(&numOne, &numTwo)
print("after:\nnumOne = \(numOne), numTwo = \(numTwo)")


print("===================== Function Type =====================")
// addTwoInts(_:_)
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    a + b
}
// the variable type is a function: (Int, Int) -> Int
var mathFunction: (Int, Int) -> Int = addTwoInts
print("result = \(mathFunction(1, 2))")

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 10, 100)

func subtractTwoInts(_ a: Int, _ b: Int) -> Int {
  a - b
}

func produceMathFunction(type: String) -> ((Int, Int) -> Int)? {
    print("Producing \(type) function")
    if type == "add" {
      return addTwoInts
    } else if type == "subtract" {
      return subtractTwoInts
    } else {
      return nil
    }
}
print(produceMathFunction(type: "add")!(50, 100))


print("===================== Closure =====================")
func forward(_ s1: String, _ s2: String) -> Bool {
    s1 < s2
}
func backward(_ s1: String, _ s2: String) -> Bool {
    s1 > s2
}
let languages = ["Kotlin", "Dart", "Swift"]
let sortedForward = languages.sorted(by: forward)
let sortedBackward = languages.sorted(by: backward)
print("sorted forward: \(sortedForward)")
print("sorted backward: \(sortedBackward)")

// 使用 closure 完成调用
let sortedWithClosure = languages.sorted(by: {
  (s1: String, s2: String) -> Bool in s1 < s2
})
let sortedWithClosureOneLiner = languages.sorted(by: { s1, s2 in s1 < s2 })
let sortedWithClosureNoArgs = languages.sorted(by: { $0 < $1 })
let sortedWithClosureOperator = languages.sorted(by: <)
let sortedWithTrailingClosure = languages.sorted { $0 < $1 }
print("sorted with closure: \(sortedWithTrailingClosure)")



print("===================== Closure chained call =====================")
func download(_ file: String, from: String) -> String? {
  print("Downloading \(file) from \(from)")
  return Int.random(in: 0...1) > 0 ? file : nil
}

func downloadPicture(name: String, onComplete: (String) -> Void, onFailure: () -> Void) {
    if let picture = download(name, from: "picture sever") {
        onComplete(picture)
    } else {
        onFailure()
    }
}

downloadPicture(name: "photo.jpg") { picture in
    print("\"\(picture)\" is now downloaded!")
} onFailure: {
    print("Couldn't download the picture.")
}


print("===================== Closure capture values =====================")
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    // capture outside scope variables and values
    func incrementer() -> Int {
        // holds a reference of runningTotal and amount
        // the references will be kept until this closure is no longer used
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

// a closure maintain it's own values (runningTotal)
var incrementByTen = makeIncrementer(forIncrement: 10)
let incrementBySeven = makeIncrementer(forIncrement: 7)
print("Result = \(incrementByTen())")
print("Result = \(incrementByTen())")
print("Result = \(incrementByTen())")
print("Result = \(incrementBySeven())") // 7!