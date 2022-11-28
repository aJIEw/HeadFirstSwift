var globalVariable: String = "Swift"

func gloablFunc() {
    @SmallNumber var version: Int = 5
    print("\(globalVariable) \(version)")
}

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


        print("===================== Properties =====================")
        var rect = MixedRectangle(width: 15, height: 15)
        print("\(rect)\nwidth = \(rect.width), height = \(rect.height)")


        print("===================== Error Handling =====================")
        let vendingMachine = VendingMachine();
        let name = "Chips"
        buy(vendingMachine, name, deposit: 15)
        buy(vendingMachine, name, deposit: 15)
        buy(vendingMachine, name, deposit: 15)


        print("===================== Nested Types =====================")
        let cto = Manager(name: "Tim", jobTitle: .CEO)
        cto.attendMeeting(meetingName: "Product Release Date")


        print("===================== Protocols =====================")
        var lightSwitch = OnOffSwitch.on
        print("light is \(lightSwitch)")
        lightSwitch.toggle()
        print("light is \(lightSwitch)")


        print("===================== Extensions =====================")
        do {
            vendingMachine.putCoin(10)
            try vendingMachine.playSong(name: "Rain and Tears")
        } catch {
            print("Can't play this song, something went wrong: \(error)")
            vendingMachine.refundRemaining()
        }
    }

    // generic function
    static func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }

    static func buy(_ vendingMachine: VendingMachine, _ name: String, deposit: Int? = nil) {
        print("Buying \(name) from vending machine")

        let coins = deposit ?? 12;
        vendingMachine.putCoin(coins)

        do {
            try vendingMachine.vend(name: name)
            print("Enjoy your \(name)!")
        } catch {
            print("Can't vend you \(name), something went wrong: \(error)")
            vendingMachine.refundRemaining()
        }
    }
}
