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

