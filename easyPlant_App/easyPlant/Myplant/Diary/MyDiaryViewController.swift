//
//  myDiaryViewController.swift
//  easyPlant_myPlant
//
//  Created by νμλΉ on 2021/04/30.
//

import UIKit
import FirebaseAuth
class MyDiaryViewController: UIViewController {
    var myplant : UserPlant?
    var diary : Diary?
    var index : Int?

    @IBOutlet weak var viewClear: UIView!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var contentVie: UIView!
    @IBOutlet weak var stackVIew: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI(){
        
        if let diary = diary, let plant = myplant {
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: stackVIew.frame.width, y: 0))

            // Create a `CAShapeLayer` that uses that `UIBezierPath`:
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.systemGray3.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 2

            lineView.layer.addSublayer(shapeLayer)
            
            downloadDiaryImage(imgview: imageLabel, title: diary.picture)
            titleLabel.text = "  " + diary.title
            
            let attributedString = NSMutableAttributedString(string: "  " + diary.story)

            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()

            // *** set LineSpacing property in points ***
            paragraphStyle.alignment = .justified
            paragraphStyle.lineSpacing = 10 // Whatever line spacing you want in points
            
            
            // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attributedString.length))

            diaryLabel.attributedText =  attributedString
            myplant = plant
            dateLabel.text = "  " + diary.date
            
         
        }
        
        //κΈ°ν UI μ€μ 
        self.navigationItem.title = myplant?.name
        diaryLabel.layer.cornerRadius = 20
        titleLabel.layer.cornerRadius = titleLabel.frame.height / 3
        contentVie.layer.cornerRadius = 30
        contentVie.layer.zPosition = 100
        imageLabel.layer.zPosition = 99
    
    }
    
    
    //κ³΅μ  λ²νΌμ΄ λλ Έλ€λ©΄
    @IBAction func shareButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        
        guard let image = imageLabel.image else { return }
            let activityController = UIActivityViewController(activityItems: [image],applicationActivities: nil)
            
            //   μμ΄ν¨λμμλ§ μ€νλκ³  μμ΄ν°μ μλμ¬ μλ μλ€
            activityController.popoverPresentationController?.sourceView = sender as! UIButton
            present(activityController, animated: true, completion: nil) //μ΄κ² handler, μ½λμ‘°κ°μ μ μ ν  μ μλ€. νμ€λ² κΈ°μ€μ΄ λ²νΌμ΄ λ  κ²μ΄λ€
    }
    

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "editDiarySegue"{
            if let detailVC = segue.destination as? WriteDiaryViewController{
                detailVC.editDiary = diary
                detailVC.userplant = myplant
                detailVC.image = imageLabel.image
                detailVC.isEdit = true
            }
        }
        
        
        if segue.identifier == "deleteDiary"{
            if let detailVC = segue.destination as? MyPlantViewController{
                detailVC.myPlant = myplant
                detailVC.isDeleteDiary = true
            }
        }
    }
    
    
    //λ€μ΄μ΄λ¦¬ μμ νκΈ° λ²νΌμ΄ λλ Έλ€λ©΄
    @IBAction func editButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        let alert = UIAlertController(title: "λ€μ΄μ΄λ¦¬ κ΄λ¦¬", message: "", preferredStyle: .actionSheet)
        
        //μμ νκΈ°
            alert.addAction(UIAlertAction(title: "λ€μ΄μ΄λ¦¬ μμ νκΈ°", style: .default , handler:{ (UIAlertAction) in
                
                //μμ νκ³  μ μ₯νκΈ°
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "editDiarySegue", sender: MyPlantViewController.self)
            }))

        //μ­μ νκΈ°
            alert.addAction(UIAlertAction(title: "λ€μ΄μ΄λ¦¬ μ§μ°κΈ°", style: .destructive , handler:{ (UIAlertAction)in
                if let picture = self.diary?.picture{
                    deleteDiaryImage(title: picture)
                    self.myplant?.diarylist.remove(at: self.index!)
                    
                    for i in 0...(userPlants.count-1) {
                        if(userPlants[i].name == self.myplant?.name){
                            print("delete diary success")
                            userPlants[i].diarylist.remove(at: self.index!)
                            break
                        }
                        
                    }
                }
            
        //μμ νκ³  μ μ₯νκΈ°
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "deleteDiary", sender: MyDiaryViewController.self)
                
            }))
            
        //ν΄μ νκΈ° λ²νΌ
            alert.addAction(UIAlertAction(title: "μ·¨μ", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    
    }
        
    
    
    @IBAction func unwindToEditDiary(_ unwindSegue: UIStoryboardSegue) {
        updateUI()
    }
    
    

    func showAlert() {
        let alert = UIAlertController(title: "λ‘κ·ΈμΈμ΄ νμν μλΉμ€μλλ€", message: "λ‘κ·ΈμΈ ν μ΄μ©λ°λλλ€", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "νμΈ", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    



}

