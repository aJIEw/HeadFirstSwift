struct Item {
    var price: Int
    var count: Int
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 2),
        "Pretzels": Item(price: 7, count: 11)
    ]

    var coinsDeposited = 0

    func putCoin(_ number: Int) {
        coinsDeposited = number
        print("You put in \(number) \(getCoinLabel()).")
    }

    func vend(name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard coinsDeposited >= item.price else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")

        refundRemaining()
    }

    func refundRemaining() {
        if coinsDeposited > 0 {
          print("Returning \(coinsDeposited) \(getCoinLabel()) back")
          coinsDeposited = 0
        }
    }

    func getCoinLabel() -> String {
        coinsDeposited > 1 ? "coins" : "coin"
    }
}