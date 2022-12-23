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
var serverResponseCode: Int? = nil

if serverResponseCode != nil {
	  print("response code: \(serverResponseCode!)")
} else {
    print("no reponse")
}

enum ResponseException: String, Error {
  case noCode
}

let fetchedResponse = Int("200") // return Int?
// optional binding
guard let response = fetchedResponse else {
  print("no response code")
  throw ResponseException.noCode
}
print("fetched response code: \(response)")


print("===================== assert & precondition =====================")
var index = 4
if index < 10 {
  print("index = \(index)")
}

precondition(index > 3)
assert(index > 3)

print("=====================>End of file.")