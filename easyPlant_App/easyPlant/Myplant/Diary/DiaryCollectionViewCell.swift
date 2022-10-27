//
//  diaryCollectionViewCell.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit

class DiaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func update(info : Diary){
  
        imageView.layer.cornerRadius = 5
        downloadDiaryImage(imgview: imageView!, title: "\(info.picture)")
    }
}
