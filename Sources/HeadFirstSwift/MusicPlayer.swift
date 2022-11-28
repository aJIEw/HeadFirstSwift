extension VendingMachine {
    // computed instance property
    var singleSongPrice: Int {
        get {
            inventory["Chips"]?.price ?? 5
        }

        set(price) {
            print("set new price at \(price)")
            inventory["Chips"]?.price = price
        }
    }

    /// instance method
    func playSong(name: String) throws {
        guard coinsDeposited >= singleSongPrice  else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: singleSongPrice)
        }

        // access instance properties and methods
        coinsDeposited -= singleSongPrice

        refundRemaining()

        print("Thanks for your coins, now playing \(name)...")
    }
}