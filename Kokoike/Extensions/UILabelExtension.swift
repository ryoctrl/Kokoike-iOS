//
//  UILabelExtension.swift
//  Kokoike
//
//  Created by mosin on 2019/03/07.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func fitAndLineBreak() {
        self.numberOfLines = 0
        self.sizeToFit()
        self.lineBreakMode = .byWordWrapping
    }
}
