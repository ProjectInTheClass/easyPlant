//
//  uerPlantsCollectionViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "userPlantCell"

let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("savingUserPlants.json")


class UserPlantCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var userPlantCollectionView: UICollectionView!
    @IBOutlet weak var myProfile: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        userPlantCollectionView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadUserPlant()
        userPlantCollectionView.reloadData()

        let imagetmp : UIImageView = UIImageView()
        let image = UIImage(named: "profileDefault2")
        imagetmp.image = image
        
        //만약 로그인된 상태고 전에 한번 수정한적 있다면
        if Auth.auth().currentUser != nil && myUser.isChangeProfile == 1{
            downloadProfileImage(imgview: imagetmp)
        }
        myProfile.setImage(imagetmp.image, for: .normal)
        myProfile.layer.cornerRadius = myProfile.frame.size.width/2
        
        userPlantCollectionView.layer.cornerRadius = 20
        

    }
    
    
    //아래는 컬랙션 뷰 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
   }

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userPlants.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPlantCollectionViewCell

        let userplant = userPlants[indexPath.row]
        cell.update(info: userplant)
       
       
       cell.layer.zPosition = 101
       setShadowView(view: cell, height: 3, shadowRadius: 5)
//       setShadowView(view: cell)
       
       return cell
   }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        let width  = (userPlantCollectionView.frame.width-16)/2
            return CGSize(width: width, height: width + 30 + 8 + 8)
        }


    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
        
   
    //unwind 설정 함수들
    @IBAction func unwindToUserPlants(_ unwindSegue: UIStoryboardSegue) {
        userPlantCollectionView.reloadData()
        
    }
    
    
    @IBAction func unwindToNewPlantsList(_ unwindSegue: UIStoryboardSegue) {
        userPlantCollectionView.reloadData()
    }
    
    
    
    //버튼이 클릭될때 불리는 함수들
    @IBAction func profileImageClicked(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            //만약 로그인이 안된 상태라면
            performSegue(withIdentifier: "toLoginPage", sender: nil)
        } else {
            //만약 로그인이 된 상태라면
            performSegue(withIdentifier: "toMypage", sender: nil)
        }
    }
    
    @IBAction func plusBtnClicked(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            //만약 로그인이 안된 상태라면
            performSegue(withIdentifier: "toLoginPage", sender: nil)
        } else {
            //만약 로그인이 된 상태라면
            performSegue(withIdentifier: "makeNewUserPlant", sender: nil)
        }
    }
    
    
    //prepare 함수로 준비단계
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? MyPlantViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  userPlantCollectionView.indexPath(for: cell) {
            detailVC.myPlant = userPlants[indexPath.item]

        }
        
        
        if segue.identifier == "makeNewUserPlant"{
            if let detailVC = segue.destination as?  EditUserPlantTableViewController{
                detailVC.editPlant = UserPlant()
                detailVC.isEdit = false

            }
        }
        
        if segue.identifier == "toMypage"{
            if let detailVC = segue.destination as?  MypageViewController{
                detailVC.navigationItem.title = myUser.userName + "님"
                detailVC.plantCollectionView = self
            }
            
        }
        
        if segue.identifier == "toLoginPage" {
            if let nav = segue.destination as? CustomNavigationController, let detailVC = nav.topViewController as? LoginViewController{
                detailVC.userPlantCollectionDelegate = self
                detailVC.plantCollectionView = self
            }
        }
        
    }
    
}

protocol userPlantCollectionDelegate {
    func reloadCollectionView()
}

extension UserPlantCollectionViewController : userPlantCollectionDelegate {
    func reloadCollectionView() {
        userPlantCollectionView.reloadData()
        print("=== update userplant ==== ")
        print(userPlants)
        
    }
}


