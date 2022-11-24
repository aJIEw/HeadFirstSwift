print("===================== Array =====================")
var someInts: [Int] = [0, 1]
var twoInts = Array(repeating: 2, count: 2)
var threeInts = [Int](repeating: 3, count: 3)
var combinedInts = someInts + twoInts + threeInts
print(combinedInts)

var basket = ["apple", "banana", "orange"]
basket.insert("blueberry", at: 1)
print(basket)
basket.removeLast();
print(basket)

for (index, value) in basket.enumerated() {
    print("Item at \(index): \(value)")
}


print("===================== Set =====================")
var langs: Set<String> = ["kotlin", "dart", "swift"]
if langs.contains("swift") {
    print("Hi, Swift!")
}


print("===================== Dictionary =====================")
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