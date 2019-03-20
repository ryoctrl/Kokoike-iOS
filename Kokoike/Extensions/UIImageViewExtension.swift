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
        guard let url = URL(string: url) else { return }
        loadImageAsynchronously(url: url)
//        do {
//            let data = try Data(contentsOf: url)
//            let image = UIImage(data: data)
//            self.image = image
//        } catch let err {
//            print("Error : \(err.localizedDescription)")
//        }
    }
    
    func loadImageAsynchronously(url: URL) -> Void {
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                    }
                    return
                }
            } catch {
                return
            }
        }
    }
    
    func loadImageAsynchronously(url: URL?, defaultUIImage: UIImage? = nil) -> Void {
        
        if url == nil {
            self.image = defaultUIImage
            return
        }
        
        DispatchQueue.global().async {
            do {
                let imageData: Data? = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if let data = imageData {
                        self.image = UIImage(data: data)
                    } else {
                        self.image = defaultUIImage
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    self.image = defaultUIImage
                }
            }
        }
    }
}
