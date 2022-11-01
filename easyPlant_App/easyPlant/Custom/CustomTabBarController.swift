//
//  CustomTabBarController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/05/23.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundColor = UIColor.systemBackground
        self.tabBarController?.selectedIndex = 1

    }

}
