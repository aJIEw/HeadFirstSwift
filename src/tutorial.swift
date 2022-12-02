print("===================== Enum =====================")
enum Card {
    case three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace, two
}

enum ListType {
  case course(Int), exam(Int, String)
}

let cards: [Card] = [.three, .four, .five]
print(cards)

let typeList: [ListType] = [.course(3), .exam(1, "uid")]
switch(typeList[1]) {
case let .exam(id, uid):
  print("exam id = \(id), exam uid = \(uid)")
default:
  print("not supported")
}


print("===================== Concurrency =====================")
func fetchUserId() async -> Int {
    print("fetching user id")
    try? await Task.sleep(nanoseconds: 1000_000_000)
    return Int.random(in: 1..<5)
}

Task {
  let userId = await fetchUserId()
  print("User id = \(userId)")
}

// delay to wait for task to finish
try? await Task.sleep(nanoseconds: 2000_000_000)


