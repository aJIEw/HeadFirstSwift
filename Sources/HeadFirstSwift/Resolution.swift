public struct Resolution {
    var width = 0
    var height = 0

    func getResolution() -> String {
      return "width: \(width), height: \(height)"
    }

    mutating func doubleWidth() {
      self.width *= 2
    }
}