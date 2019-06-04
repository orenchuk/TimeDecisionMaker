//
//  Event.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

struct Appointment {
    var start: Date?
    var end: Date?
    var stamp: Date?
    var uid: String?
    var created: Date?
    var description: String?
    var lastModified: Date?
    var location: String?
    var sequence: Int?
    var status: String?
    var summary: String?
    var transp: String?
    var isAllDay = false
    
    enum Keys: String {
        case start = "DTSTART"
        case startDay = "DTSTART;VALUE=DATE"
        case end = "DTEND"
        case endDay = "DTEND;VALUE=DATE"
        case stamp = "DTSTAMP"
        case uid = "UID"
        case created = "CREATED"
        case description = "DESCRIPTION"
        case lastModified = "LAST-MODIFIED"
        case location = "LOCATION"
        case sequence = "SEQUENCE"
        case status = "STATUS"
        case summary = "SUMMARY"
        case transp = "TRANSP"
    }
}
