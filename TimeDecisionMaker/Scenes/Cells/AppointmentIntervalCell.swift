//
//  AppointmentIntervalCell.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/5/19.
//

import UIKit

final class AppointmentIntervalCell: UITableViewCell {
    
    // MARK: - Properties
    
    var start: Date? {
        willSet {
            if let date = newValue {
                intervalStartLabel.text = "\(date.string())"
            }
        }
    }
    
    var end: Date? {
        willSet {
            if let date = newValue {
                intervalEndLabel.text = "\(date.string())"
            }
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var background: UIView!
    @IBOutlet private weak var intervalStartLabel: UILabel!
    @IBOutlet private weak var intervalEndLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        self.background.roundCorners(radius: Constants.Radius.standart)
    }
    
}
