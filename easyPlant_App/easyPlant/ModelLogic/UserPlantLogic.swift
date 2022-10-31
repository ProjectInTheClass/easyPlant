//
//  UserPlantRepository.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import FirebaseStorage
import FirebaseAuth


let storage = Storage.storage()
let storageRef =  Storage.storage().reference()


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

