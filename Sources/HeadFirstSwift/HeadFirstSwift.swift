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

        if normal === blueray {
            print("They are the same.")
        }


        print("===================== Subscripts =====================")

    }
}
