//
//  PlantType.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation

var plantType = PlantType(
    type : ["전체검색","공기정화","그늘에서","성장속도","귀차니즘","인테리어","꽃과열매"],
    plantAll : [plantTotal, plantsClearAir, plantsShade, plantsFast, plantsLazy, plantsInterior, plantsFlower]

)

struct PlantType:Codable{
    var type: [String]
    var plantAll: [[Plant]]
    
}
