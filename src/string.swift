let someString = "some string literals \(3*2)\n"
print("some string = \(someString)")

let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."

"""
print(quotation)


let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"

"""
print(threeDoubleQuotationMarks)


print(#"Write an "extended delimiters" string in Swift using #"."#)

let threeMoreDoubleQuotationMarks = #"""

Here are three more double quotes: """\n

"""#
print(threeMoreDoubleQuotationMarks)


var str = "Swift"
print("\(str), count: \(str.count)")

let endIndex = str.endIndex
let startIndex = str.startIndex

var lastCharIndex = str.index(before: endIndex)
print("first: \(str[startIndex]), last: \(str[lastCharIndex])")

var charIndex = str.index(startIndex, offsetBy: 2)
print("char at \(charIndex.utf16Offset(in: str)): \(str[charIndex])")

str.insert("!", at: endIndex)
print("insert !: \(str)")

str.insert(contentsOf: "Hello ", at: startIndex)
print("insert Hello: \(str)")

str.remove(at: str.index(before: str.endIndex))
print("remove last char: \(str)")

let range = startIndex..<str.firstIndex(of: "S")!
str.removeSubrange(range)
print("remove first word: \(str)")

let greeting = "Hi, Swift!"
let start = greeting.firstIndex(of: "S")!
let end = greeting.firstIndex(of: "!")!
let substring = greeting[start...end]
// let substring = greeting[start..<end]
print("substring =\"\(substring)\"")

var substringToNewString = String(substring)