//
//  Calendar.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

struct Calendar {
    var prodid: String?
    var version: String?
    var scale: String?
    var method: String?
    var name: String?
    var timezone: String?
    var events: [Event]?
    
    enum Keys: String {
        case prodid = "PRODID"
        case version = "VERSION"
        case scale = "CALSCALE"
        case method = "METHOD"
        case name = "X-WR-CALNAME"
        case timezone = "X-WR-TIMEZONE"
    }

}

extension Calendar {
    init(from path: String) {
        if let values = ICSFileManager.shared.read(from: path) {
            self = ICSFileParser.shared.parse(values: values)
        } else {
            self.init()
        }
    }
}
