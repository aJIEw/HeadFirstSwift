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
var someInts: [Int] = [0, 1]  // 类型可省略
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
namesOfIntegers[1] = "one" // 使用 subscript 访问或赋值
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

#### Optional Chaining

我们可以链式调用可为空的值：

```swift
if let hasRmb = person.wallert?.rmb?.notEmpty {
    print("You can pay with RMB.")
} else {
    print("Insufficient funds.")
}
```

#### guard

`guard` 和 `if` 的区别在于，它要求条件必须为 `true` 才能执行后面的代码，并且总是包含一个 `else` 语句。

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

  	// 使用 guard 后，optional binding 中的变量在后面的作用域中也可用了
    print("Hello \(name)!") // 改成 if 后试试

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

### Enumeration

枚举值语法：

```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}

// or
enum CompassPoint {
    case north, south, east, west
}
```

使用枚举类：

```swift
var direction = CompassPoint.north
// 枚举变量定义后修改可以不写枚举类
direction = .west

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

// 继承 CaseIterable 后就可以遍历枚举类的所有值了
enum CompassPoint: CaseIterable { ... }

// 使用 allCases 属性获取所有枚举值
print("There're \(CompassPoint.allCases.count) directions, and they are:")
// 遍历
for direction in CompassPoint.allCases {
    print(direction)
}

// 枚举类默认是没有原始数据类型 (raw type) 的，但是我们可以通过继承自指定类型后获得
// 比如继承 Int，则原始数据类型就是随定义位置自增的 Int，继承自 String 就是对应的字符串
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// 使用 rawValue 访问原始数据
print("Earth is No.\(Planet.earth.rawValue) in the solar system.")
```

### Structures and Classes

#### 模块

到目前为止，以上所有代码执行环境都可以视为在脚本中执行，但是，当我们开始构建大型项目之后，我们不可能将所有的代码都写在一个文件中，我们需要将代码抽象化成结构和类以复用代码。除此之外，我们还可能需要将自己的代码封装成一个模块 (*module*) 给其他人调用。

在 Swift 中，一个模块是一个最小的代码分发单元，它可以表示一个库 (*library*)、框架 (*framework*)、可执行包 (*executable package*)、应用 (*application*) 等，当导入一个模块后，你就可以使用其中任何公共的方法和数据模型了。

虽然 `struct` 和 `class` 可以定义在同一个文件中，但是我觉得最好还是创建一个新的模块，用单独的文件保存，因此，先介绍一下模块的知识，关于访问控制 (*Access Control*) 相关的知识之后再慢慢介绍。

##### Swift Package Manager

我们可以使用 Swift 包管理器创建和发布库 (*library*) 和可执行包 (*executable package*)。

```sh
mkdir MySwiftPackage
cd MySwiftPackage

# 在 MySwiftPackage 文件夹下创建一个可执行包
swift package init --type executable
# 运行
swift run
```

- 基本使用：[Using the Package Manager](https://www.swift.org/getting-started/#using-the-package-manager)
- 具体用法：[swift-package-manager](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md)
- API 文档：[Package Description API](https://docs.swift.org/package-manager/PackageDescription/index.html)

#### Struct vs Class

`struct` 和 `class` 在 Swift 都是组织代码的基本结构，它们有很多共同点，比如：

- 都可以定义属性、方法和 subscripts
- 都可以定义初始化器
- 都可以被扩展增加功能
- 都可以实现 protocols 来实现特定用途

不同之处在于，类相比结构有更多特殊功能：

- 类可以被继承
- 类支持类型转换和运行时类型检查
- 可以在销毁方法中释放资源
- 可以使用引用计数，一个类实例可以有多个引用

除此之外，`struct` 和 `class` 的用法基本一致，定义一个 struct：

```swift
struct Resolution {
    var width = 0
    var height = 0
}
```

定义一个类：

```swift
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

创建实例：

```swift
// struct 有默认的初始化方法 (memberwise initializer)，可以在其中为所有属性赋值
var hd = Resolution(width: 1920, height: 1080)

// 类只有一个默认构造器
var videoMode = VideoMode()
```

#### 作为值类型的 `struct` 和 `enum`

在 Swift 中，变量和常量分为两种类型，一种是作为值类型，一种是作为引用类型，基本数据类型 `Int` `Float` `Double` `Bool` `String`，以及集合类型 `Array` `Set` `Dictionary` 都是值类型，它们背后都是基于 `struct` 实现的。也就是说，当把它们作为变量传递时，传递的都是值的拷贝，而不是引用。

`enum` 实例也是一样：

```swift
var direction = CompassPoint.north
var newDirection = direction
direction = .west
print(newDirection) // still north!
```

因此，当我们需要改变值类型时，一般需要在实例方法上添加 `mutating` 关键字：

```swift
mutating func changeDirection(_ newDirection: CompassPoint) {
    self = newDirection
}
```

#### 作为引用类型的 `class`

不同于 `struct`，类的实例是作为引用类型使用的，这点毋庸置疑。

```swift
var normal = VideoMode()
normal.name = "Normal"
normal.resolution = sd
normal.frameRate = 60
print("\(normal.name!)-> resolution: \(normal.resolution)")

var blueray = normal
blueray.name = "Blueray"
normal.resolution = hd
normal.frameRate = 90
print("\(blueray.name!)-> resolution: \(blueray.resolution)")
```

以上例子中，`blueray` 拷贝了 `normal` 的引用，所以当我们修改 `normal` 的属性时，`blueray` 的属性也会得到修改。

为了判断两个类的实例是否相等，Swift 中引入了一致性判断操作符 (*Identity Operator*) `===` 和 `!==`：

```swift
if normal === blueray {
    print("They are the same.")
}
```

#### Properties

根据是否保存值来看，属性可以分成两种，分别是存值属性 (*Stored Properties*) 和计算后属性 (*Computed Properties*)。

##### Stored Properties

存值属性通常在类 (`class`) 和结构 (`struct`) 中作为常量 (`var`) 和变量 (`let`) 使用。

```swift
struct SomeStruct {
    let someConstant = 0
    var someVar = 0
    // 延迟初始化属性
  	lazy var importer = DataImporter()
}
```

##### Computed Properties

计算后属性除了可以在类和结构中使用外，也可以在枚举类中使用，它不保存值，但是会提供 getter 方法和可选的 setter 方法从其它属性或值间接地计算或设值后得到。

```swift
class SomeClass {
    var computed: Int = {
        get {
            // 根据其它属性计算得到返回值
        }
        // optional
        set(newValue) {
            // 更新相关联的属性，从而计算新值
        }
        // 也可以不写 setter，直接使用返回值作为 getter
        // 那么，该计算后属性就是 read-only 的
        // return 10
    }
}
```

##### Property Observers

我们还可以在属性上设置监听器，从而在属性设值之前和设值之后做一些操作。对于存值属性，我们通过 `willSet` 和 `didSet` 方法监听；对于计算后属性，则可以通过 set 方法监听。

```swift
struct SomeStruct {
    var someVar: Int {
        willSet(newValue) {
            print("Before set new value")
        }
        didSet {
            // 旧值用 oldValue 表示
            print("new value = \(someVar), old value = \(oldValue)")
        }
    }
}
```

##### Property Wrappers

当我们定义了如何存储一个属性时，为了复用代码，我们可以将它作为模板使用。

```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
```

比如以上定义了一个限制最大值的 property wrapper 之后，可以这样使用：

```swift
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
```

这样，使用了该 property wrapper 的属性最大值会被限制为 12。

我们也可以在 property wrapper 上设置初始化值：

```swift
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
  
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
  
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
```

通过添加构造器方法，使得我们可以指定初始值。

```swift
struct MixedRectangle {
    @SmallNumber(maximum: 20) var width: Int = 2
    @SmallNumber var height: Int = 1
}
```

##### Global and Local Variables

我们可以像属性一样设置全局变量，不过全局变量总是会被延迟初始化。我们也可以为全局变量或者本地变量设置监听器，但是不可以为全局变量或计算后变量设置 property wrapper。

```swift
var globalVariable: String = "Swift"

func gloablFunc() {
    @SmallNumber var version: Int = 5
    print("\(globalVariable) \(version)")
}
```

##### Type Properties

类型属性也就是静态属性，不需要通过创建实例而是可以直接通过类型访问的属性。

#### Methods

方法分为实例方法 (*instance method*) 和类型方法 (*type methods*)，类型方法也就是 Objective-C 中的类方法。相比 C 和 Objective-C，Swift 最大的不同在于，除了 `class` 之外，`struct` 和 `enum` 类中也能定义方法。

##### 实例方法

```swift
func getResolution() -> String {
  return "width: \(width), height: \(height)"
}
```

##### 类型方法

在 Swift 中，同样使用 `static` 关键字声明类型方法，对于类而言，还可以使用 `class func` 关键字，这样子类就可以继承和覆写父类中的类型方法了。

```swift
class SomeClass {
    class func someTypeMethod() {
        // do something
    }
}

struct SomeStruct {
		static func someTypeMethod() {
        // do something
    }
}
```

#### Subscripts

Subscript 是创建对集合、列表等的成员进行访问和赋值的语法。我们能够通过下标访问数组、字典等都是因为其内部实现了 subscript 方法。

我们可以在任意的类、结构或枚举类中使用 subscript，其语法如下：

```swift
subscript(index: Int) -> Int {
    get {
        // 返回值
    }
    set(newValue) {
        // 赋值
    }
}
```

`subcript` 可以指定任意的参数和任意类型的返回值，也可以为参数设置默认值和使用可变参数列表，但是不可以使用 `inout` 参数。

##### Type Subscript

类型 subscript 和类型方法相似，是直接作用于类型之上的方法。

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune

    // 添加类型 subscript，直接通过下标创建枚举类实例
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

var mars = Planet[4]
```

#### Initialization

`class` 和 `struct` 的构造器方法是 `init`：

```swift
init(argumentLabel parameterName: Type, ...) {
    // 初始化常量和属性等
  	self.someValue = someValue
}
```

如果初始化参数标签和属性名相同，可以使用 `self` 引用类中的属性，类似于其他语言中的 `this`。

##### `required` init

我们可以将某个构造器方法标记为 `required`：

```swift
class SomeClass {
    required init(param: Type) {
        // initializer implementation goes here
    }
}
```

这样的话，子类就必须实现它：

```swift
class SomeSubclass: SomeClass {
    required init(param: Type) {
        // subclass implementation of the required initializer goes here
    }
}
```

#### Deinitialization

类相比 `struct` 还多了一个销毁的方法 `deinit`，在类实例被销毁之前被调用：

```swift
deinit {
    // 释放资源等
}
```

销毁方法会自动调用父类销毁方法，即使子类没有定义销毁方法也一样，所以我们不用担心父类销毁方法得不到调用。

#### Type Casting

Swift 中的类型检查同样使用 `is` 关键字：

```swift
if instance is Type {
    print("It's the type")
}

if !(instance is Type) {
		print("Not the type")
}
```

向下转型则使用 `as?` 和 `as!`：

```swift
// optional 转换
if let movie = item as? Movie {
    print("Movie: \(movie.name), dir. \(movie.director)")
}

// 强制类型转换
var song = item as! Song
```

#### Nested Types

我们可以在类、枚举类型、结构中定义嵌套类型。

```swift
struct Manager {
    enum JobTitle {
        case CEO, CFO, CTO, CMO, CHRO, CCO
        case vacant
    }
  	
    let name: String = ""
  	
  	var jobTitle = JobTitle.vacant
  
    func attendMeeting(meetingName: String) {
        print("\(name)(\(jobTitle)) is attending <\(meetingName)> meeting.")
    }
}
```

### Protocols

和 Objective-C 一样，Swift 中也有 protocol 的概念，我们用它来定义一组功能，然后交给子类实现，类似于其他语言中的接口概念。在 Swift 中，`enum` / `struct` / `class` 都可以实现 protocol 来增强自身的功能。

语法：

```swift
protocol SomeProtocol {
	  static var someTypeProperty: Type { get set }
  
    var mustBeSettable: Type { get set }
    var doesNotNeedToBeSettable: Type { get }
  
    init(parameterName: Type)
  
  	static func someTypeMethod(argumentLabel parameterName: Type) -> returnValue
  
  	func someMethod(argumentLabel parameterName: Type) -> returnValue
}
```

实现：

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // 实现属性和方法
}
```

#### Mutate 方法

对于值类型 (*struct & enum*)，假如想要改变属性或自身的实例，需要在方法前添加 `mutating` 关键字。

假如你确定 protocol 中的某个方法有可能会改变值且有可能会被值类型使用，则可以用 `mutating` 修饰：

```swift
protocol Togglable {
    mutating func toggle()
}
```

子类：

```swift
enum OnOffSwitch: Togglable {
    case off, on
    // 如果是被 class 实现则不需要写 mutating
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
```

##### 初始化方法

protocol 中的初始化方法都是 `required` 的，子类必须实现：

```swift
// 假如 protocol 中定义了 init() 方法
class SomeClass: SomeProtocol {
    required init() {
    }
}
```

假如子类实现同时继承了父类和实现了 protocol，则需要使用 `required override` 关键字：

```swift
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
```

### Extensions

Swift 中的 `extension` 类似于 Objective-C 中的 category，用于扩展 `enum` / `struct` / `class` / `protocol` 的功能，比如：

- 增加计算后实例变量和类型变量（*computed properties*）
- 增加实例方法 (*instance methods*) 和类型方法 (*type methods*)
- 添加新的构造器方法 (*initializers*)
- 添加 `subcript` 方法
- 添加和使用新的嵌套类型 (*nested types*)
- 实现新的 `protocol`

增加实例变量和实例方法的例子：

```swift
extension VendingMachine {
    // computed instance property
    var singleSongPrice: Int {
        return 10
    }

    /// instance method
    func playSong(name: String) throws {
        guard coinsDeposited > singleSongPrice  else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: singleSongPrice)
        }

        // access instance properties and methods
        coinsDeposited -= 5

        refundRemaining()

        print("Thanks for your coins, now playing \(name)...")
    }
}
```

注意，添加新的实例变量必须是 computed properties。

### Generics

Swift 中同样可以使用泛型。

#### 泛型方法

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```

使用：

```swift
var var1 = "var1"
var var2 = "var2"
swapTwoValues(var1, var2)
print("var1 = \(var1), var2 = \(var2)")
```

#### 类型限制

我们可以为泛型设置类型限制 (*Type Constraints*) 来明确泛型的使用边界。

```swift
func someFunc<T: SomeClass, M: SomeProtocol>(someT: T, someM: M) {
    someT.doSomething()
    someM.doSomething()
}
```

#### Associated Types

在定义 protocol 时，我们有时会需要定义一个相关的数据类型，类似于泛型类中的泛型数据类型。

```swift
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
```

上面定义了 `Container` 的 protocol，内部使用 `associatedtype` 定义了一个 Item 类作为关联类型，并且部分方法中使用到该类型。接下来我们定一个实现类：

```swift
struct IntStack: Container {
    // 指定 Container 中的 Item 类型为 Int
    typealias Item = Int
  
    var items: [Int] = []
  
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
  
    mutating func append(_ item: Int) {
        self.push(item)
    }
  
    var count: Int {
        return items.count
    }
  
    subscript(i: Int) -> Int {
        return items[i]
    }
}
```

当然，我们也可以使用泛型类来实现 `Container`：

```swift
// 标准库中 Stack 的实现
struct Stack<Element>: Container {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
```

另外，在关联类型上也可以添加类型限制。

```swift
associatedtype Item: Equatable
```

最后，关于泛型上 `where` 关键字的使用，请看[文档](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)。

#### Opaque Types

我们有时可能不想要返回具体的类型，此时就需要用到模糊类型。比如下面的例子：

```swift
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
```

我们定义了一个 `Shape` protocol，其中主要包含一个 draw 方法用来表示绘制自身形状，然后实现了两个形状类以及一个由两个形状拼接而成的合成形状。接下来我们定义一个使用这些形状的方法：

```swift
func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let bottom = Square(size: 2)
    let joinedShape = JoinedShape(
        top: top,
        bottom: bottom
    )
    return joinedShape
}
```

上面的例子中，我们使用了 `some` 关键字，这样我们就对外部隐藏了具体的形状类型，但是并不影响调用 `draw` 方法。

```swift
let trapezoid = makeTrapezoid()
trapezoid.draw()
```

### Error Handling

Swift 中的异常用 `Error` 代表，它是一个内容为空的 protocol，我们可以使用它来自定义我们的异常，通常使用 `enum` 类来实现。

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```

抛出异常的语法：

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

在 Swift 中，当遇到一个异常时，我们有 4 种处理方式：

- 向外传递异常 `throws`
- 使用 `do..catch` 语法捕捉异常
- 将异常作为可选值处理 `try?`
- 判定异常不会出现 `try!`

下面一一介绍。

#### 向外传递异常

当某个方法不去处理异常时，可以使用 `throws` 关键字将异常向外抛出：

```swift
func vend(name: String) throws {
		guard let item = inventory[name] else {
        throw VendingMachineError.invalidSelection
    }
  
  	...
}
```

#### 捕捉异常

语法：

```swift
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
```

例子：

```swift
do {
    try vendingMachine.vend(name: name)
    print("Enjoy your \(name)!")
} catch {
    // 捕捉任何异常，使用 error 获取异常类
    print("Something went wrong: \(error)")
}
```

#### 用可选值接收

当我们只是想要获取结果时，可以不对有可能抛出的异常进行处理，而是用可选值接收：

```swift
let result = try? funcMightThrows()
```

上面使用 `try?` 调用了一个有可能抛出异常的方法，调用成功则会获得结果，抛出异常则结果为 `nil`。

#### 判断异常不会出现

当我们确信不会抛出异常时，可以强制完成调用，将异常放到运行时抛出。

```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

#### `defer` 表达式

当一个方法有可能会抛出异常时，我们可能想要在异常抛出时执行一些操作，比如打开一个文件流后，如果执行过程中出现异常，我们会想要及时关闭文件流，此时可以使用 `defer` 表达式：

```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```

一个方法中可以有多个 `defer` 表达式，但是执行顺序是从下往上的，也就是最后定义的 `defer` 表达式最先执行。而且即使不抛出异常的方法，依然可以使用 `defer` 表达式。



