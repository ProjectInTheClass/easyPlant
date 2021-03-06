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
let storage = Storage.storage()
let storageRef =  Storage.storage().reference()



var clickedDay: Date = Date()

struct Color : Codable {
    
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
}

struct UserPlant : Codable {
    var name: String
    var location: String
    var recentWater : String {didSet(old) {print("===========최근 물준 날짜 변경=======")}}
    var registedDate : String
    var waterPeriod : Int
    var wateringDay : Date
    var plantSpecies : String
    var diarylist : [Diary]
    var color : Color
    var happeniess : [Int]
    var alarmTime : Date
    var plantImage : String
    var watered : Int
    var totalWaterNum: Int
    var didWaterNum: Int
    
    
    private enum CodingKeys : String, CodingKey{
        case name,location,recentWater,registedDate,waterPeriod, wateringDay,plantSpecies, diarylist,color,happeniess,alarmTime,plantImage,watered,  totalWaterNum, didWaterNum}
    
    mutating func updateHappiness() {
        happeniess.append(Int((didWaterNum * 100 ) / totalWaterNum))
        didWaterNum = 0
        totalWaterNum = 0
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(String.self, forKey: .location)
        registedDate = try container.decode(String.self, forKey: .registedDate)
        waterPeriod = try container.decode(Int.self, forKey: .waterPeriod)
        wateringDay = try container.decode(Date.self, forKey: .wateringDay)
        plantSpecies = try container.decode(String.self, forKey: .plantSpecies)
        diarylist = try container.decode([Diary].self, forKey: .diarylist)
        color = try container.decode(Color.self, forKey: .color)
        happeniess = try container.decode([Int].self, forKey: .happeniess)
        alarmTime = try container.decode(Date.self, forKey: .alarmTime)
        plantImage = try container.decode(String.self, forKey: .plantImage)
        watered = try container.decode(Int.self, forKey: .watered)
        recentWater = try container.decode(String.self, forKey: .recentWater)
        totalWaterNum = try container.decode(Int.self, forKey: .totalWaterNum)
        didWaterNum = try container.decode(Int.self, forKey: .didWaterNum)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var valueContatiner = encoder.container(keyedBy: CodingKeys.self)
        
        try valueContatiner.encode(self.name,forKey: CodingKeys.name)
        try valueContatiner.encode(self.location,forKey: CodingKeys.location)
        try valueContatiner.encode(self.registedDate,forKey: CodingKeys.registedDate)
        try valueContatiner.encode(self.waterPeriod,forKey: CodingKeys.waterPeriod)
        try valueContatiner.encode(self.wateringDay,forKey: CodingKeys.wateringDay)
        try valueContatiner.encode(self.plantSpecies,forKey: CodingKeys.plantSpecies)
        try valueContatiner.encode(self.diarylist,forKey: CodingKeys.diarylist)
        try valueContatiner.encode(self.color,forKey: CodingKeys.color)
        try valueContatiner.encode(self.happeniess,forKey: CodingKeys.happeniess)
        try valueContatiner.encode(self.alarmTime,forKey: CodingKeys.alarmTime)
        try valueContatiner.encode(self.plantImage,forKey: CodingKeys.plantImage)
        try valueContatiner.encode(self.watered,forKey: CodingKeys.watered)
        try valueContatiner.encode(self.recentWater, forKey: CodingKeys.recentWater)
        try valueContatiner.encode(self.totalWaterNum,forKey: CodingKeys.totalWaterNum)
        try valueContatiner.encode(self.didWaterNum,forKey: CodingKeys.didWaterNum)

    }
    
    
    
    init() {
        name = ""
        location = ""
        registedDate = ""
        waterPeriod = 0
        wateringDay = Date()
        plantSpecies = ""
        diarylist = []
        color = Color(uiColor: UIColor())
        happeniess = []
        alarmTime = Date()
        plantImage = "plant"
        watered = Int()
        recentWater = ""
        totalWaterNum = 0
        didWaterNum = 0
    }
    
    init(name : String, location : String, recentWater : String, registedDate : String, waterPeriod : Int, wateringDay : Date, plantSpecies : String, diarylist : [Diary], color : Color, happeniess : [Int], alarmTime : Date, plantImage : String, watered : Int, totalWaterNum : Int, didWaterNum : Int) {
        self.name = name
        self.location = location
        self.registedDate = registedDate
        self.waterPeriod = waterPeriod
        self.wateringDay = wateringDay
        self.plantSpecies = plantSpecies
        self.diarylist = diarylist
        self.color = color
        self.happeniess = happeniess
        self.alarmTime = alarmTime
        self.plantImage = plantImage
        self.watered = watered
        self.recentWater = recentWater
        self.totalWaterNum = totalWaterNum
        self.didWaterNum = didWaterNum
    }
    
}
    

  
var listPlantsIndex: [Int] = []

var userPlants : [UserPlant] = [UserPlant(name: "초록콩", location: "샘플", recentWater : "2021-06-02", registedDate: "2010-10-30",  waterPeriod: 5, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 200/255, green: 1/255, blue: 1/255, alpha: 1)), happeniess: [86,65,67,98,87,68,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "Corokia.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "까망콩", location: "샘플", recentWater : "2021-06-04", registedDate: "2010-10-30", waterPeriod: 3, wateringDay: Date(), plantSpecies: "샘플",  diarylist: diarys, color: Color(uiColor: UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)), happeniess: [86,65,57,76], alarmTime: Date(timeIntervalSinceNow: 66) ,plantImage: "CornPlant.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "연두콩", location: "샘플", recentWater : "2021-06-06",registedDate: "2010-10-30", waterPeriod: 1, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 20/255, green: 180/255, blue: 30/255, alpha: 1)), happeniess:  [86,65,67,98,87,64,76,77,89,76], alarmTime: Date(timeIntervalSinceNow: 15), plantImage: "Syngonium.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0),
                                UserPlant(name: "파란콩", location: "샘플", recentWater : "2021-06-05",registedDate: "2010-10-30", waterPeriod: 2, wateringDay: Date(), plantSpecies: "샘플", diarylist: diarys, color: Color(uiColor: UIColor(red: 150/255, green: 220/255, blue: 200/255, alpha: 1)), happeniess:  [86,65,67,98,87,68,76,77,89,74], alarmTime: Date(timeIntervalSinceNow: 66) , plantImage: "Monstrous.jpeg", watered: 0, totalWaterNum: 0, didWaterNum: 0)]


func  saveNewUserPlant(plantsList : [UserPlant], archiveURL : URL) {
    let jsonEncoder = JSONEncoder()
    
    do{
        let encodeData = try jsonEncoder.encode(plantsList)
        
        // 원격에 저장
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/userPlantList/plants"
            
            let metaData = StorageMetadata()
            metaData.contentType = "application/json"
            storageRef.child(filePath).putData(encodeData ,metadata: metaData){
                (metaData,error) in if let error = error{
                    print(error.localizedDescription)
                    return
                }
                else{
                    //print("성공")
                }
            }
            // 로컬에 저장
            try encodeData.write(to: archiveURL, options: .noFileProtection)
        }
        
        

      }
      catch {
          print(error)
      }

}


func loadUserPlant(){
    let jsonDecoder = JSONDecoder()
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: archiveURL){
        //로컬에 정보가 존재할 경우 로컬 저장소에서 사용
        do {
            let decoded = try jsonDecoder.decode([UserPlant].self, from: data as Data)
            userPlants = decoded
        } catch {
            print(error)
        }
    }
    else {
        // Create a reference to the file you want to download
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/userPlantList/plants"
        } else {
            filePath = "/sampleUser/userPlantList/plants"
        }
        let infoRef = storageRef.child(filePath)

        
        // Download to the local filesystem
        infoRef.write(toFile: archiveURL) { url, error in
          if let error = error {
            print("download to local userPlants error : \(error)")

          } else {
            let data = NSData(contentsOf: url!)
            do {
                let decoded = try jsonDecoder.decode([UserPlant].self, from: data! as Data)
                userPlants = decoded
            } catch {
                print(error)
            }
          }
        }
    }

}




func downloadUserPlantImage(imgview:UIImageView, title : String){
    let urlString:String = documentsDirectory.absoluteString + "localPlant/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localPlant/\(title)")
        // Create a reference to the file you want to download
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/userPlant/\(title)"
        } else {
            filePath = "/sampleUser/userPlant/\(title).jpeg"
        }
        
        let imgRef = storageRef.child(filePath)
    
        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local error : \(error)")

          } else {
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }

        
    }

    
 }
 
 
func uploadUserPlantImage(img :UIImage, title: String){
    
     
     var data = Data()
    data = img.jpegData(compressionQuality: 0.7)!
    var filePath = ""
    if let user = Auth.auth().currentUser {
        filePath = "/\(user.uid)/userPlant/\(title)"
    } else {
        filePath = "/sampleUser/userPlant/\(title)"
    }
     let metaData = StorageMetadata()
     metaData.contentType = "image/png"
     storageRef.child(filePath).putData(data,metadata: metaData){
             (metaData,error) in if let error = error{
             print(error.localizedDescription)
             return
                 
         }
     }

 }

func deleteUserPlantImage(title : String){
    //식물 사진 지우기
    // Create a reference to the file to delete
    var desertRef = storageRef.child("")
    if let user = Auth.auth().currentUser {
        desertRef = storageRef.child("/\(user.uid)/userPlant/\(title)")
    } else {
        desertRef = storageRef.child("/sampleUser/userPlant/\(title)")
    }

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete user plant error + \(error)")
      } else {
        //print("delete user plant success")
      }
    }
    
    // 1. 인스턴스 생성 - 동일
    let fileManager = FileManager.default
    let urlString:String = documentsDirectory.absoluteString + "localPlant/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
   
    // Try Catch
    do {
        // 5-1. 삭제하기
        try fileManager.removeItem(at: localURL)
    } catch let e {
        // 5-2. 에러처리
        print(e.localizedDescription)
    }
    
    
    
    
 
}
 
func deleteUserPlantDiaryImage(title : String){
    //해당 식물 찾아오기
    var targetPlant : UserPlant?
    for i in 0...(userPlants.count-1) {
        if(userPlants[i].name == title){
            targetPlant = userPlants[i]
        }
    }
    
    //해당 식물의 다이어리 지우기
    for diary in targetPlant!.diarylist {
        deleteDiaryImage(title: diary.picture)
    }
    
}

