//
//  userPlant.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth



var userPlants : [UserPlant] = [UserPlant(name: "초록콩", location: "샘플", recentWater : "2021-06-02", registedDate: "2010-10-30",  waterPeriod: 5, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 200/255, green: 1/255, blue: 1/255, alpha: 1)), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "Corokia.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "까망콩", location: "샘플", recentWater : "2021-06-04", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "샘플",  diarylist: diarys, color: Color(uiColor: UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)), happeniess: [86,65,57,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "CornPlant.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "연두콩", location: "샘플", recentWater : "2021-06-06",registedDate: "2010-10-30", waterPeriod: 1, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 20/255, green: 180/255, blue: 30/255, alpha: 1)), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 15), plantImage: "Syngonium.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "파란콩", location: "샘플", recentWater : "2021-06-05",registedDate: "2010-10-30", waterPeriod: 2, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 150/255, green: 220/255, blue: 200/255, alpha: 1)), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date(timeIntervalSinceNow: 66) , plantImage: "Monstrous.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0)]

struct UserPlant : Codable {
    var name: String = ""
    var location: String = ""
    var recentWater : String = "" {didSet(old) {print("===========최근 물준 날짜 변경=======")}}
    var registedDate : String = ""
    var waterPeriod : Int = 0
    var wateringDay : Date = Date()
    var plantSpecies : String = ""
    var diarylist : [Diary] = []
    var color : Color = Color(uiColor: UIColor())
    var happeniess : [Int] = []
    var alarmTime : Date = Date()
    var plantImage : String = "plant"
    var watered : Int = 0
    var totalWaterNum: Int = 0
    var didWaterNum: Int = 0
    
    
    mutating func updateHappiness() {
        happeniess.append(Int((didWaterNum * 100 ) / totalWaterNum))
        didWaterNum = 0
        totalWaterNum = 0
    }
    
    
//    init(name : String, location : String, recentWater : String, registedDate : String, waterPeriod : Int, wateringDay : Date, plantSpecies : String, diarylist : [Diary], color : Color, happeniess : [Int], alarmTime : Date, plantImage : String, watered : Int, totalWaterNum : Int, didWaterNum : Int) {
//        self.name = name
//        self.location = location
//        self.registedDate = registedDate
//        self.waterPeriod = waterPeriod
//        self.wateringDay = wateringDay
//        self.plantSpecies = plantSpecies
//        self.diarylist = diarylist
//        self.color = color
//        self.happeniess = happeniess
//        self.alarmTime = alarmTime
//        self.plantImage = plantImage
//        self.watered = watered
//        self.recentWater = recentWater
//        self.totalWaterNum = totalWaterNum
//        self.didWaterNum = didWaterNum
//    }
    
}
    

