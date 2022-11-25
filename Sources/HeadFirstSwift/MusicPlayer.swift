extension VendingMachine {
    // computed instance property
    var singleSongPrice: Int {
        return 10
    }

    func playSong(name: String) throws {
        guard coinsDeposited > singleSongPrice  else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: singleSongPrice)
        }

        coinsDeposited -= 5

        refundRemaining()

        print("Thanks for your coins, now playing \(name)...")
    }
}