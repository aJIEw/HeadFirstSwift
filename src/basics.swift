print("===================== Constant and Variable =====================")
let constant: String = "Swift"
var version = "5.7.1"
print("Hello, \(constant) \(version)!")


print("===================== typealias =====================")
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
print(maxAmplitudeFound)


print("===================== Tuple =====================")
let http404Error = (404, "Not Found")
print(http404Error.1)

let http200Success = (code: 200, result: "OK")
print("The result is \(http200Success.result)")


print("===================== Optionals =====================")
var serverResponseCode: Int? = 200

// optional binding
if serverResponseCode != nil {
	  print("response code unwrapped: \(serverResponseCode!)!")
}

enum ResponseException: String, Error {
  case noCode
}

let fetchedResponse: Int? = 200 // try set to nil
// guard will only execute when it's true, and alawys contains an else
guard let response = fetchedResponse else {
  print("no response")
  // Unsually we will throw an exception in else
  throw ResponseException.noCode
}
print("fetched response code: \(response)")


print("===================== assert & precondition =====================")
var index = 4
if index < 10 {
  print("index = \(index)")
}

assert(index > 3)
// assert only works in debug, while precondition works both on debug and production
precondition(index > 3)

print("=====================>End of file.")