//
//  ICSCalendar.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

struct ICSCalendar {
    var prodid: String?
    var version: String?
    var scale: String?
    var method: String?
    var name: String?
    var timezone: String?
    var appointments: [Appointment]?
    
    enum Keys: String {
        case prodid = "PRODID"
        case version = "VERSION"
        case scale = "CALSCALE"
        case method = "METHOD"
        case name = "X-WR-CALNAME"
        case timezone = "X-WR-TIMEZONE"
    }

}

extension ICSCalendar {
    init(from path: String) {
        if let values = ICSFileManager.shared.read(from: path) {
            var calendar = ICSFileParser.shared.parse(values: values)
            calendar.sortAppointments()
            
            self = calendar
        } else {
            self.init()
        }
    }
    
    private mutating func sortAppointments() {
        self.appointments?.sort(by: {
            if let first = $0.start, let second = $1.start {
                return first.compare(second) == .orderedAscending ? true : false
            }
            fatalError()
        })
    }
}
