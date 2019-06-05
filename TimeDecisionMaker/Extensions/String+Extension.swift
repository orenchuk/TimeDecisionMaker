//
//  String+Extension.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/2/19.
//

import Foundation

extension String {
    func toKeyValuePair(separator: Character) -> (key: String, value: String)? {
        guard self.contains(separator) else { return nil }
        
        let substrings = self.split(separator: separator, maxSplits: 1)
        
        guard substrings.count == 2 else { return nil }
        
        let key = String(substrings[0])
        let value = String(substrings[1])
        
        return (key, value)
    }
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        
        return dateFormatter.date(from: self)
    }
    
    func toDay() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.date(from: self)
        
        return date
    }
}
