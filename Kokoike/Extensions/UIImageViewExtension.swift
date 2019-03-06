//
//  UIImageViewExtension.swift
//  Kokoike
//
//  Created by mosin on 2019/03/06.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func displayFromURL(_ url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            self.image = image
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
    }
}
