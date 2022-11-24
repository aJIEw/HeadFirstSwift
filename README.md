## HeadFirstSwift

Swift 是在 2014 年苹果开发者大会上面世的新语言，相比 Objective-C，它的语法更简洁，也更现代化。

这篇学习笔记主要参考自 [learnxinyminutes.com](https://learnxinyminutes.com/docs/swift/) 和 [Swift 官方文档](https://docs.swift.org/swift-book/)。

### The Basics

Swift 是一门现代化的语言，它的语法和 Kotlin 非常相似，因此，我这里只会整理出一些特殊的地方。

#### 常量和变量

Swift 中使用 `let` 关键字声明常量，`var` 关键字声明变量。

```swift
let constant: String = "Swift"
var version = "5.7.1"
print("Hello, \(constant) \(version)!")
```

不同于 Objective-C，Swift 不需要一个 `main` 方法作为程序入口，我们可以直接将上述代码保存成文件，比如 `basics.swift`，然后使用下面的命令运行它：

```sh
swift basics.swift
```

#### 类型别名

给已有的类型添加别名，用关键字 `typealias` 表示。

```swift
// 定义别名 unsigned UInt 16
typealias AudioSample = UInt16

// 使用别名调用原来类型上的属性或方法
var maxAmplitudeFound = AudioSample.min
```

使用别名可以增加代码的可读性，我们可以在某些情况下，根据当前上下文为类添加别名。

#### Tuple

元组是 Swift 中独有的数据类型，用于表示一组值。

```swift
// 用 () 创建元组
let http404Error = (404, "Not Found")

// 解构赋值
let (statusCode, statusMessage) = http404Error

// 根据下标访问元组
print(http404Error.1)

// 也可以给元素命名
let http200Success = (code: 200, result: "OK")
print("The result is \(http200Success.result))
```

元组最大的用途是在方法中作为返回值，当我们需要返回多个不同类型的数据时就可以使用元组。

#### Optionals

类似于 Kotlin 中的 nullable 和 Dart 中的 null safe，用于表示一个变量可能没有值。

用法也非常相似，不同的地方在于，它需要使用 `!` 转换 (*unwrap*) 后才能使用：

```swift
var serverResponseCode: Int? = nil

if serverResponseCode != nil {
	  print("response code: \(serverResponseCode!)")
}
```

##### Optional Binding

我们可以使用 optional binding 的语法检查某个 optional 是否有值，语法如下：

```swift
if let constantName = someOptional {
    statements
}
```

需要注意的是，通过这种语法创建的常量，只有在该语句下才能使用。

##### Implicitly Unwrapped Optionals

当我们确定某个可选变量一定有值时，可以使用隐式转换，使得一个可选变量可以直接访问而不用再进行转换。

```swift
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString
```

#### Assertions and Preconditions

我们可以使用 `assert` 和 `precondition` 检测条件是否满足，它们两者的区别是 `assert` 只在 debug 阶段运行，而 `precondition` 则在 debug 和 production 下都会运行。

```swift
var index = 3
precondition(index > 3)
assert(index > 3)
```

### String

Swift 中的字符串用法和 Kotlin 基本一致，比如多行字符串等。

#### 扩展分隔符

当字符串中包含多个转义字符的时候，我们可以使用扩展分隔符，语法是在字符串前后都加上 `#`：

```swift
print(#"Write an "extended delimiters" string in Swift using #\n"."#)
```

#### 字符串插值

Kotlin 中可以使用 `$` 在字符串中引用变量，Swift 中使用 `\()`。

```swift
let someString = "some string literals \(3*2)\n"
print("some string = \(someString)")
```

#### 字符串常用方法

##### 长度和字符串下标

通过 `count` 获取字符串长度。由于 Swift 中字符串中的每个字符可能使用不同数量的内存空间，所以无法直接使用 int 下标访问，而必须通过字符串下标 ([*String.Index*](https://developer.apple.com/documentation/swift/string/index))：

```swift
var str = "Swift"
print("count: \(str.count)")

let endIndex = str.endIndex
let startIndex = str.startIndex

var lastCharIndex = str.index(before: endIndex)
print("first: \(str[startIndex]), last: \(str[lastCharIndex])")

var charIndex = str.index(startIndex, offsetBy: 2)
print("char at \(charIndex.utf16Offset(in: str)): \(str[charIndex])")
```

上面的例子中，`startIndex` 表示字符串中第一个字符的下标，`endIndex` 表示最后一个字符之后的下标。因此，当字符串为空时，这两个值相同。

我们使用 `index` 方法获取最后一个字符的下标，然后通过 `[indexValue]` 语法获取字符串中的字符。

##### 添加和删除

```swift
str.insert("!", at: endIndex)
print("insert !: \(str)")

str.insert(contentsOf: "Hello ", at: startIndex)
print("insert Hello: \(str)")

str.remove(at: str.index(before: str.endIndex))
print("remove last char: \(str)")

let range = startIndex..<str.firstIndex(of: "S")!
str.removeSubrange(range)
print("remove first word: \(str)")
```

#### Substring

[Substring](https://developer.apple.com/documentation/swift/substring) 是字符串的一个切片，它是一个独立的类型，但是使用方式和字符串基本一致，而且所有的操作都很高效，因为 Substring 共享原有字符串的存储空间。

```swift
let greeting = "Hi, Swift!"

let start = greeting.firstIndex(of: "S")!
let end = greeting.firstIndex(of: "!")!
let substring = greeting[start...end]
print("substring =\"\(substring)\"")

var substringToNewString = String(substring))
```

### Collections

Swift 中有三种基本的集合类型，[Array](https://developer.apple.com/documentation/swift/array) / [Set](https://developer.apple.com/documentation/swift/set) / [Dictionary](https://developer.apple.com/documentation/swift/dictionary)。

#### Arrays

```swift
var someInts = [0, 1]
var threeInts = Array(repeating: 2, count: 3)
var twoInts = [Int](repeating: 3, count: 2)
var combinedInts = someInts + threeInts + twoInts
print(combinedInts)

var basket = ["apple", "banana", "orange"]
basket.insert("blueberry", at: 1)
print(basket)
basket.removeLast();
print(basket)

for (index, value) in basket.enumerated() {
    print("Item at \(index): \(value)")
}
```

#### Set

```swift
var langs: Set<String> = ["kotlin", "dart", "swift"]
if langs.contains("swift") {
    print("Hi, Swift!")
}
```

#### Dictionary

```swift
var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[1] = "one"
print(namesOfIntegers)

var languageBirth = ["Kotlin": 2011, "Dart": 2011, "Swift": 2014]
var keys = [String] (languageBirth.keys) // to array
print("languages: \(keys)")

for (lang, year) in languageBirth {
    print("\(lang) is first published at \(year)")
}

languageBirth["Dart"] = nil // remove item
print(languageBirth)
```

### Control Flow

#### For-In Loops

```swift
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
```

#### While Loops

```swift
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
```

#### Switch

Swift 中的 `switch` 语法和其它语言基本一样，不同的是在 `case` 判断中支持更多的模式匹配，比如支持多个值判断、区间判断、元组、临时赋值等。具体请看 [`control_flow.swift`](./src/control_flow.swift)。

#### guard

`guard` 和 `if` 的区别在于，它要求条件必须为 `true` 才能执行后面的代码，并且总是包含一个 `else` 语句。

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}
```

#### available

我们可以在执行代码前判断 API 是否可用：

```swift
func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}
```

### Function

Swift 中的方法同样是 first-class 的，方法可以作为参数，也可以作为返回值。

一个典型的 Swift 方法定义如下：

```swift
// 方法名称是：greeting(name:)
func greeting(name: String) -> String {
    return "Hi, \(name)!"
}
```

Swift 中的方法参数与 Objective-C 中一样，是方法名称的一部分，参数分为标签 (*argument label*) 和名称 (*parameter name*) 两部分。假如我们没有定义标签，则默认使用参数名称作为标签，如果想要使用不具名参数，则可以使用 `_` 作为标签。

```swift
// 方法名称是：greeting(for:)，参数标签和参数名称不同
func greeting(for name: String) -> String {
    return "Hi, \(name)!"
}

// 方法名称是：greeting(_:)，参数无标签
func greeting(_ name: String) -> String {
    return "Hi, \(name)"
}
```

此外，方法的参数还支持默认值、动态参数列表 (*variadic parameters*) 等。和 Kotlin 不同，Swift 中的参数还可以使用 `inout` 关键字来支持修改参数的值，具体请看 [`function.swift`](./src/function.swift)。

#### 方法类型

我们可以将方法作为数据类型使用：

```swift
// 作为变量
var mathFunction: (Int, Int) -> Int = addTwoInts

// 作为参数
func printMathResult(_ mathFunction: (Int, Int) -> Int) {
    mathFunction(1, 2)
}

// 作为返回值
func produceMathFunction() -> (Int, Int) -> Int {
    return addTwoInts
}
```

#### Closure

Swift 中的 closure 类似于 Kotlin 中的 lambda 方法以及 Objective-C 中的 blcoks。

```swift
let languages = ["Kotlin", "Dart", "Swift"]
let sortedWithClosure = languages.sorted(by: {
  (s1: String, s2: String) -> Bool in s1 < s2
})
```

以上例子中，`sorted` 方法的 `by` 参数接收的是一个方法类型，因此我们可以创建一个 closure 去完成调用。一个 closure 的完整语法如下：

```swift
{ (parameters) -> return type in
    statements
}
```

当参数和返回值的类型可以被推断出来时，可以简写成以下的形式：

```swift
let sortedWithClosureOneLiner = languages.sorted(by: { s1, s2 -> in s1 < s2 })
```

另外，在 closure 中，参数可以缩写成 `$index` 的形式，因此，以上调用可以进一步缩写成：

```swift
let sortedWithClosureNoArgs = languages.sorted(by: { $0 < $1 })
```

我们甚至可以利用操作符方法 (*Operator Methods*) 继续缩写以上调用，由于 `>` 或 `<` 在字符串中被定义为接受两个字符串参数返回值为布尔类型的方法，正好符合 `sorted` 中 `by` 接收的方法类型，因此，我们可以直接传递操作符：

```swift
let sortedWithClosureOperator = languages.sorted(by: <)
```

##### Trailing Closure

类似于 Kotlin 中的 trailing lambda，当方法最后一个参数是一个 closure 时，我们可以将 closure 调用写在 `()` 之外。而当如果 closure 是调用的唯一的参数时，则可以省略 `()`。

上面的例子用拖尾 closure 表示就是：

```swift
let sortedWithTrailingClosure = languages.sorted { $0 < $1 }
```

不同之处在于，Swift 中的拖尾表达式可以链式调用：

```swift
// 模拟下载方法
func download(_ file: String, from: String) -> String? {
    print("Downloading \(file) from \(from)")
    return Int.random(in: 0...1) > 0 ? file : nil
}

// 下载图片方法，包含两个方法类型的参数
func downloadPicture(name: String, onComplete: (String) -> Void, onFailure: () -> Void) {
    if let picture = download(name, from: "picture sever") {
        onComplete(picture)
    } else {
        onFailure()
    }
}
```

使用链式 closure 调用该方法：

```swift
downloadPicture(name: "photo.jpg") { picture in
    print("\"\(picture)\" is now downloaded!")
} onFailure: {
    print("Couldn't download the picture.")
}
```

##### Capturing Values

当我们使用 closure 时，有时会发生捕获 closure 作用域之外的值的现象：

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    // 捕获外部作用域的值
    func incrementer() -> Int {
        // incrementer 方法内部会保留 runningTotal 和 amount 的引用，
        // 直到该方法不再被使用
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

