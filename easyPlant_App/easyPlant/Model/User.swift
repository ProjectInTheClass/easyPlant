//
//  User.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation
import UIKit
import FirebaseAuth


var myUser: User!

struct User : Codable{
    var level: Level
    var growingDays: Int
    var numPlants: Int
    var userName:String
    var isChangeProfile: Int
    var hapiness: Int //int형으로 바꿨어
    let registeredDate: Date
    
    
    
    init(_ registeredDate: Date) {
        level = levels[0]
        growingDays = 0
        numPlants = 0
        hapiness = 100
        self.registeredDate = registeredDate
        userName = "사용자"
        isChangeProfile = 0
    }
    
    mutating func updateUser() {
        //여기에 사용자이름 업데이트 해주기 - 회원가입시에
        if let updateName = (Auth.auth().currentUser?.displayName){
            userName = updateName
        }
               
        numPlants = userPlants.count
        growingDays = Calendar.current.dateComponents([.day], from: registeredDate, to: Date()).day!
        
        hapiness = 0
        for plant in userPlants {
            var total_happy = 0
            for happy in plant.happeniess {
                total_happy += happy
            }
            if total_happy != 0 {
                hapiness += total_happy / plant.happeniess.count

            }
            
        }
        
        if userPlants.count != 0 {
            hapiness /= userPlants.count
        } else {
            hapiness = 100
        }
        
        for standard in levels {
            if Int(standard.hapiness) <= hapiness && standard.numPlants <= numPlants && standard.growingDays <= growingDays {
                self.level = standard
            }
        }
    }
}

