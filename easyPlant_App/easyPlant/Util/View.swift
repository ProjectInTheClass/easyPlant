//
//  View.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import UIKit

func setShadowView(view: UIView, opacity: Float = 0.2, height: Int = 5, shadowRadius: CGFloat = 30) {
    view.layer.shadowOpacity = opacity
    view.layer.shadowOffset = CGSize(width: 0, height: height)
    view.layer.shadowRadius = shadowRadius
    view.layer.masksToBounds = false
}


extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 30
        self.layer.shadowOffset = CGSize(width: 0, height: -10)

        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
}
