//
//  Button.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import UIKit


extension UIButton {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
       let border = CALayer()
       border.backgroundColor = UIColor.easyPlantPrimary.cgColor
       border.frame = CGRect(x:0 + 10, y:self.frame.size.height - width, width:self.frame.size.width - 20, height:width)
       self.layer.addSublayer(border)
   }
}
