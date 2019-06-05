//
//  RDTimeDecisionMaker.swift
//  TimeDecisionMaker
//
//  Created by Mikhail on 4/24/19.
//

import Foundation

class RDTimeDecisionMaker: NSObject {
    /// Main method to perform date interval calculation
    ///
    /// - Parameters:
    ///   - organizerICSPath: path to personA file with events
    ///   - attendeeICSPath: path to personB file with events
    ///   - duration: desired duration of appointment
    /// - Returns: array of available time slots, empty array if none found
    func suggestAppointments(organizerICS:String,
                             attendeeICS:String,
                             duration:TimeInterval) -> [DateInterval] {
        
        var intervals = [DateInterval]()
        
        let organizerCalendar = ICSCalendar(from: organizerICS)
        let attendeeCalendar = ICSCalendar(from: attendeeICS)
        
        let organizerFreeTime = getFreeTimeIntervals(calendar: organizerCalendar, duration: duration)
        let attendeeFreeTime = getFreeTimeIntervals(calendar: attendeeCalendar, duration: duration)
        
        for organizerInterval in organizerFreeTime {
            for attendeeInterval in attendeeFreeTime {
                if organizerInterval.end.compare(attendeeInterval.start) != .orderedAscending,
                    organizerInterval.start.compare(attendeeInterval.end) != .orderedDescending {
                    
                    if organizerInterval.start.compare(attendeeInterval.start) != .orderedDescending {
                        if organizerInterval.end.compare(attendeeInterval.end) != .orderedDescending {
                            let interval = DateInterval(start: attendeeInterval.start, end: organizerInterval.end)
                            intervals.append(interval)
                        } else {
                            let interval = DateInterval(start: organizerInterval.start, end: attendeeInterval.end)
                            intervals.append(interval)
                        }
                    } else {
                        if organizerInterval.end.compare(attendeeInterval.end) != .orderedDescending {
                            let interval = DateInterval(start: organizerInterval.start, end: organizerInterval.end)
                            intervals.append(interval)
                        } else {
                            let interval = DateInterval(start: organizerInterval.start, end: attendeeInterval.end)
                            intervals.append(interval)
                        }
                    }
                }
            }
        }
        
        return intervals.filter { $0.duration >= duration }
    }
    
    private func getFreeTimeIntervals(calendar: ICSCalendar, duration: TimeInterval) -> [DateInterval] {
        var intervals = [DateInterval]()
        
        guard let appointments = calendar.appointments?.filter({ !$0.isAllDay }) else { return [] }
        
        if let beforeEvents = includeBeforeEventsTime(appointments: appointments, duration: duration) {
            intervals.append(beforeEvents)
        }
        
        for (index, appointment) in appointments.enumerated() {
            let indexNext = index + 1
            guard indexNext < appointments.count else { continue }
            let nextAppointment = appointments[indexNext]
            
            if let first = appointment.end, let second = nextAppointment.start {
                guard first.compare(second) == .orderedAscending else { continue }
                let dateInterval = DateInterval(start: first, end: second)
                if dateInterval.duration >= duration {
                    intervals.append(dateInterval)
                }
            }
        }
        
        if let afterEvents = includeAfterEventsTime(appointments: appointments, duration: duration) {
            intervals.append(afterEvents)
        }

        return intervals
    }
    
    private func includeBeforeEventsTime(appointments: [Appointment], duration: TimeInterval) -> DateInterval? {
        guard let first = appointments.first?.start else { return nil }
        let interval = DateInterval(start: first.startOfDay, end: first)
        return interval.duration >= duration ? interval : nil
    }
    
    private func includeAfterEventsTime(appointments: [Appointment], duration: TimeInterval) -> DateInterval? {
        guard let last = appointments.last?.end else { return nil }
        let interval = DateInterval(start: last, end: last.endOfDay)
        return interval.duration >= duration ? interval : nil
    }
}
