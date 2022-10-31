//
//  UserRepository.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import FirebaseStorage
import FirebaseAuth


let userInfoURL = documentsDirectory.appendingPathComponent("savingUserInfo.json")

// 사용자가 처음 식물을 등록한 날로 바꿔야 함.
func deleteLocalData() {
    let fileManager = FileManager.default
   
    // Try Catch
    do {
        // 5-1. 삭제하기
        // User info 삭제
        try fileManager.removeItem(at: userInfoURL)
        // Plant list 삭제
        try fileManager.removeItem(at: archiveURL)
    } catch let e {
        // 5-2. 에러처리
        print(e.localizedDescription)
    }
}

func loadUserInfo(){
    let jsonDecoder = JSONDecoder()
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: userInfoURL){
        //로컬에 정보가 존재할 경우 로컬 저장소에서 사용
        do {
            let decoded = try jsonDecoder.decode(User.self, from: data as Data)
            myUser = decoded
        } catch {
            print(error)
        }
    }
    else {
 
        // Create a reference to the file you want to download
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/userInfo/info"
        } else {
            filePath = "/sampleUser/userInfo/info"
        }
        
        let infoRef = storageRef.child(filePath)
        
        // Download to the local filesystem
        infoRef.write(toFile: userInfoURL) { url, error in
          if let error = error {
            print("download to local user info error : \(error)")

          } else {
            let data = NSData(contentsOf: url!)
            do {
                let decoded = try jsonDecoder.decode(User.self, from: data! as Data)
                myUser = decoded
            } catch {
                print(error)
            }
          }
        }
   }

}


func  saveUserInfo(user : User) {
    
    let jsonEncoder = JSONEncoder()
    
    do{
        let encodeData = try jsonEncoder.encode(user)
        // 원격에 저장
        
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/userInfo/info"
            
            let metaData = StorageMetadata()
            metaData.contentType = "application/json"
            storageRef.child(filePath).putData(encodeData ,metadata: metaData){
                (metaData,error) in if let error = error{
                    print(error.localizedDescription)
                    return
                }
                else{
                    //print("save user info 성공")
                }
            }
            
            // 로컬에 저장
            try encodeData.write(to: userInfoURL, options: .noFileProtection)
        }
      }
      catch {
          print(error)
      }
}



func downloadProfileImage(imgview:UIImageView){
    let urlString:String = documentsDirectory.absoluteString + "localProfile/profile"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localProfile/profile")
        // Create a reference to the file you want to download
        var filePath = "/profile/profile"
        
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/profile/profile"
        } else {
            filePath = "/sampleUser/profile/profile"
        }
        let imgRef = storageRef.child(filePath)

        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local error : \(error)")

          } else {
            //print(url)
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }

        
    }
    
    
    
 }
 
func uploadProfileImage(img :UIImage){
    
     
     var data = Data()
    data = img.jpegData(compressionQuality: 0.7)!
    var filePath = "/profile/profile"
    
    if let user = Auth.auth().currentUser {
        filePath = "/\(user.uid)/profile/profile"
    } else {
        filePath = "/sampleUser/profile/profile"
    }
    
     let metaData = StorageMetadata()
     metaData.contentType = "image/png"
     storageRef.child(filePath).putData(data,metadata: metaData){
             (metaData,error) in if let error = error{
             print(error.localizedDescription)
             return
                 
         }
         else{
             //print("upload profile image 성공")
         }
     }

 }

func deleteProfileImage(){
    // Create a reference to the file to delete
    var desertRef = storageRef.child("/")
    if let user = Auth.auth().currentUser {
        desertRef = storageRef.child("/\(user.uid)/profile/profile")
    } else {
        desertRef = storageRef.child("/sampleUser/profile/profile")
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
    let urlString:String = documentsDirectory.absoluteString + "localProfile/profile"
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
