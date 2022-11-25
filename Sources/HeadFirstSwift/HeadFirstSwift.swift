@main
public struct HeadFirstSwift {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print("===================== struct & class =====================")

        var hd = Resolution(width: 1920, height: 1080)
        var sd = Resolution(width: 1280, height: 600)

        VideoMode.changeDefaultResolution(hd)
        var normal = VideoMode.getDefaultMode()
        print("Default one: \(normal.resolution)")
        normal.name = "Normal"
        normal.resolution = sd
        normal.frameRate = 60
        print("\(normal.name!)-> resolution: \(normal.resolution), framerate: \(normal.frameRate)")

        var blueray = normal
        blueray.name = "Blueray"
        normal.resolution = hd
        normal.frameRate = 90
        print("\(blueray.name!)-> resolution: \(blueray.resolution), framerate: \(blueray.frameRate)")

        // type check
        if !(blueray is Resolution) {
            print("blueray is not Resolution")
        }

        // reference check
        if normal === blueray {
            print("They are the same.")
        }


        print("===================== Error Handling =====================")
        let vendingMachine = VendingMachine();

        func buy(_ vendingMachine: VendingMachine, _ name: String, deposit: Int? = nil) {
            print("Buying \(name) from vending machine")

            let coins = deposit ?? 12;
            vendingMachine.coinsDeposited = coins
            print("You deposited \(coins) coins.")

            do {
                try vendingMachine.vend(name: name)
                print("Enjoy your \(name)!")
            } catch {
                print("Something went wrong: \(error)")
            }
        }

        let name = "Chips"
        buy(vendingMachine, name, deposit: 15)
        buy(vendingMachine, name, deposit: 15)
        buy(vendingMachine, name, deposit: 15)
        buy(vendingMachine, name, deposit: 15)


        print("===================== Nested Types =====================")
        let cto = Manager(name: "Tim", jobTitle: .CTO)
        cto.attendMeeting(meetingName: "Product Release Date")
    }
}
