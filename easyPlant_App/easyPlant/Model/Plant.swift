//
//  plant.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import Foundation
import UIKit


var plantTotal: [Plant] = []
var plantsClearAir: [Plant] = []
var plantsShade: [Plant] = []
var plantsFast: [Plant] = []
var plantsLazy: [Plant] = []
var plantsInterior: [Plant] = []
var plantsFlower: [Plant] = []

struct Plant: Codable {
    var dic : [String: String] = [:]
    
    mutating func initDic(){
        for key in plantKey.keys{
            self.dic.updateValue("", forKey: key)
        }
    }
}

