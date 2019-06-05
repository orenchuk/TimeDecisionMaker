//
//  UIView+Extension.swift
//  TimeDecisionMaker
//
//  Created by Yevhenii Orenchuk on 6/5/19.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
