//
//  DiaryLogic.swift
//  easyPlant
//
//  Created by 현수빈 on 2022/10/27.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth



func downloadDiaryImage(imgview:UIImageView, title : String){
    print(title)
    let urlString:String = documentsDirectory.absoluteString + "localDiary/\(title)"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localDiary/\(title)")
        // Create a reference to the file you want to download
        var filePath = ""
        if let user = Auth.auth().currentUser {
            filePath = "/\(user.uid)/diary/\(title)"
        } else {
            filePath = "/sampleUser/diary/\(title).jpeg"
        }
        let imgRef = storageRef.child(filePath)

        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local diary error : \(error)")
          } else {
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }
    }
    
 
}


func uploadDiaryImage(img :UIImage, title: String){
   
    
    var data = Data()
    data = img.jpegData(compressionQuality: 0.7)!
    var filePath = ""
    if let user = Auth.auth().currentUser {
        filePath = "/\(user.uid)/diary/\(title)"
    } else {
        filePath = "/sampleUser/diary/\(title).jpeg"
    }
    let metaData = StorageMetadata()
    metaData.contentType = "image/png"
    storageRef.child(filePath).putData(data,metadata: metaData){
            (metaData,error) in if let error = error{
            print(error.localizedDescription)
            return
                
        }
        else{
          //  print("upload diary image 성공")
        }
    }

}

func deleteDiaryImage(title : String){
    // Create a reference to the file to delete
    var desertRef = storageRef.child("")
    if let user = Auth.auth().currentUser {
        desertRef = storageRef.child("/\(user.uid)/diary/\(title)")
    } else {
        desertRef = storageRef.child("/sampleUser/diary/\(title).jpeg")
    }

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete diary error + \(error)")
      } else {
       // print("delete diary success")
      }
    }
    
    // 1. 인스턴스 생성 - 동일
    let fileManager = FileManager.default
    let urlString:String = documentsDirectory.absoluteString + "localDiary/\(title)"
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
