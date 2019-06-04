//
//  ICSParser.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

final class ICSFileParser {
    
    // MARK: - Properties
    
    static let shared = ICSFileParser()
    
    // MARK: - Public methods
    
    func parse(values: [String]) -> ICSCalendar {
        
        var calendar = ICSCalendar()
        var currentEvent = Appointment()
        
        for line in values {
            switch line {
            case "BEGIN:VCALENDAR":
                calendar.appointments = [Appointment]()
            case "BEGIN:VEVENT":
                currentEvent = Appointment()
            case "END:VEVENT":
                calendar.appointments?.append(currentEvent)
            case "END:VCALENDAR":
                return calendar
            default:
                guard let (key, value) = line.toKeyValuePair(separator: ":") else { break }
                
                if let eventKey = Appointment.Keys(rawValue: key) {
                    switch eventKey {
                    case .start:
                        currentEvent.start = value.toDate()
                    case .startDay:
                        currentEvent.start = value.toDay()
                        currentEvent.isAllDay = true
                    case .end:
                        currentEvent.end = value.toDate()
                    case .endDay:
                        currentEvent.end = value.toDay()
                    case .stamp:
                        currentEvent.stamp = value.toDate()
                    case .uid:
                        currentEvent.uid = value
                    case .created:
                        currentEvent.created = value.toDate()
                    case .description:
                        currentEvent.description = value
                    case .lastModified:
                        currentEvent.lastModified = value.toDate()
                    case .location:
                        currentEvent.location = value
                    case .sequence:
                        currentEvent.sequence = Int(value)
                    case .status:
                        currentEvent.status = value
                    case .summary:
                        currentEvent.summary = value
                    case .transp:
                        currentEvent.transp = value
                    }
                } else if let calendarKey = ICSCalendar.Keys(rawValue: key) {
                    switch calendarKey {
                    case .prodid:
                        calendar.prodid = value
                    case .version:
                        calendar.version = value
                    case .scale:
                        calendar.scale = value
                    case .method:
                        calendar.method = value
                    case .name:
                        calendar.name = value
                    case .timezone:
                        calendar.timezone = value
                    }
                }
            }
        }
        
        return calendar
    }
}
