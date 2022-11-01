//
//  ImageView.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(_ link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    self.image = UIImage(data: data) }
            }
        }).resume()
    }

}
