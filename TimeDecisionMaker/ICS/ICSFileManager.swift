//
//  ICS.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

final class ICSFileManager {
    
    // MARK: - Properties
    
    static let shared = ICSFileManager()
    
    // MARK: - Public methods
    
    func read(from path: String) -> [String]? {
        do {
            let contents = try String(contentsOfFile: path)
            let lines = contents.components(separatedBy: "\n").filter { !$0.isEmpty }
            return lines.map { $0.replacingOccurrences(of: "\r", with: "") }
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
    
    func read(filename: String) -> [String]? {
        if let filepath = Bundle.main.path(forResource: filename, ofType: "ics") {
            return read(from: filepath)
        } else {
            debugPrint("file not found!")
        }
        
        return nil
    }
}
