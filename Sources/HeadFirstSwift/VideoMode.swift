class VideoMode {
    static var defaultResolution = Resolution(width: 1080, height: 800)

    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?

    class func getDefaultMode() -> VideoMode {
        var videoMode = VideoMode()
        videoMode.resolution = defaultResolution
        videoMode.frameRate = 30;
        videoMode.name = "Default"
        return videoMode
    }

    static func changeDefaultResolution(_ resolution: Resolution) {
      defaultResolution = resolution
    }
}