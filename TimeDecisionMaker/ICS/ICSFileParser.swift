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
    
    func parse(values: [String]) -> Calendar {
        
        var calendar = Calendar()
        var currentEvent = Event()
        
        for line in values {
            switch line {
            case "BEGIN:VCALENDAR":
                calendar.events = [Event]()
            case "BEGIN:VEVENT":
                currentEvent = Event()
            case "END:VEVENT":
                calendar.events?.append(currentEvent)
            case "END:VCALENDAR":
                return calendar
            default:
                guard let (key, value) = line.toKeyValuePair(separator: ":") else { break }
                
                if let eventKey = Event.Keys(rawValue: key) {
                    switch eventKey {
                    case .start:
                        currentEvent.start = value.toDate()
                    case .end:
                        currentEvent.end = value.toDate()
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
                } else if let calendarKey = Calendar.Keys(rawValue: key) {
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
