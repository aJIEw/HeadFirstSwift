struct Manager {
    enum JobTitle {
        case CEO, CFO, CTO, CMO, CHRO, CCO
        case vacant
    }
  	
    var name: String = ""
  	
  	var jobTitle = JobTitle.vacant

    init(name: String, jobTitle: JobTitle? = nil) {
      self.name = name
      guard let title = jobTitle else {
          print("No job title")
          return
      }

      self.jobTitle = title

      if title == .CTO {
        print("There's a new CTO: \(name)")
      }
    }
  
  	func attendMeeting(meetingName: String) {
        print("\(name)(\(jobTitle)) is attending <\(meetingName)> meeting.")
    }
}