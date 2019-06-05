//
//  AppointmetnsViewModel.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/5/19.
//

import Foundation

final class AppointmetnsViewModel {
    
    // MARK: - Properties
    
    var intervals = [DateInterval]()
    
    private let decisionMaker = RDTimeDecisionMaker()
    
    private lazy var organizerFilePath: String? = Bundle.main.path(forResource: "A", ofType: "ics")
    private lazy var attendeeFilePath: String? = Bundle.main.path(forResource: "B", ofType: "ics")
    
    // MARK: - Public methods
    
    func suggestFreeIntervals(duration: TimeInterval) {
        guard let orgPath = organizerFilePath, let attendeePath = attendeeFilePath else { fatalError("Test files should exist") }
        
        self.intervals = decisionMaker.suggestAppointments(organizerICS: orgPath, attendeeICS: attendeePath, duration: duration)
    }
    
}
