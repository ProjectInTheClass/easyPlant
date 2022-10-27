//
//  myPlantViewController.swift
//  easyPlant_myPlant
//
//  Created by 현수빈 on 2021/04/30.
//

import UIKit
import Charts
import FirebaseStorage
import Photos
import PhotosUI
import FirebaseAuth
private let reuseIdentifier = "diaryCell"


class MyPlantViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate, UICollectionViewDelegateFlowLayout {

    var myPlant : UserPlant?
    var numbers : [Int] = []
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    var ChartEntry : [ChartDataEntry] = []
    var selectedImage : UIImage?
    var isDeleteDiary : Bool = false
    var dateString: String = ""
   
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var happeniessLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var chartBackgroundView: UIView!
    
    @IBOutlet weak var labelStackView: UIStackView!
    
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speciesLabel2: UILabel!
    @IBOutlet weak var locationLabel2: UILabel!
    @IBOutlet weak var happinessLabel2: UILabel!
    
    @IBOutlet weak var diaryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        loadUserPlant()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = myPlant?.name
        myPlantUpdate()
        updateUI()
        diaryCollectionView.reloadData()
       
    }
    
    func updateUI(){

        
        backgroundView.layer.cornerRadius = 10
        
        diaryView.clipsToBounds = true
        diaryView.layer.cornerRadius = 20
        diaryView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        diaryView.layer.zPosition = 101
        imageView.layer.zPosition = 101
        
       
        if let myPlant = myPlant {
            //등록일 위치 종류 데이터 불러오기
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            
            let dateRegister:Date = dateFormatter.date(from: myPlant.registedDate)!
            let days = Calendar.current.dateComponents([.day], from: dateRegister, to: Date()).day!
            self.days.text = "함께한지 \(days)일째🌱"
            
            locationLabel.text = myPlant.location
            speciesLabel.text = myPlant.plantSpecies
            
            //행복도 불러오기
            if(myPlant.happeniess.count != 0 ){
                happeniessLabel.text = "\(myPlant.happeniess[myPlant.happeniess.count-1])"
            }
            else{
                happeniessLabel.text = "0"
            }
            
            //이미지 불러오기
            downloadUserPlantImage(imgview: imageView, title: myPlant.plantImage)
            imageView.layer.cornerRadius = imageView.frame.width / 2.0
            imageView.layer.masksToBounds = true
            
            numbers = myPlant.happeniess
            
            //테두리 밖은 잘려서 표시됨
            dDayLabel?.layer.masksToBounds = true
            locationLabel?.layer.masksToBounds = true
            speciesLabel?.layer.masksToBounds = true
            happeniessLabel?.layer.masksToBounds = true
            
        }

        var value : ChartDataEntry
        ChartEntry = []
        
        var x = 0
        // chart data array 에 데이터 추가
        for i in 0..<months.count {
            let lastIndex = numbers.count-1
            let nowIndex = lastIndex - (months.count-1-i)
            
            if(numbers.count > nowIndex && nowIndex >= 0){
                value = ChartDataEntry(x: Double(x), y: Double(numbers[nowIndex]))
                x += 1
                ChartEntry.append(value)

            }
        }
        
        if ChartEntry.count < 12 {
            
            let extra = 12 - ChartEntry.count
            
            for _ in 1...extra{
                
                value = ChartDataEntry(x: Double(x), y: 0.0)
                ChartEntry.append(value)
                x += 1
            }
        }
 
        //차트 설정
        let chartDataset = LineChartDataSet(entries: ChartEntry, label: "올해의 행복도 변화")
        let chartData = LineChartData(dataSet: chartDataset)
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.drawBordersEnabled = false
        chartView.xAxis.enabled = false
  
        var circleColors: [NSUIColor] = []           // arrays with circle color definitions
        let color = UIColor(red: CGFloat(174.0/255), green: CGFloat(213.0/255), blue: CGFloat(129.0/255), alpha: 1)
        circleColors.append(color)
        

        // set colors and enable value drawing
        chartDataset.colors = circleColors
        chartDataset.circleHoleColor = color
        chartDataset.circleColors = circleColors
        chartDataset.drawValuesEnabled = true
        

        chartView.data = chartData
        //chartView.layer.cornerRadius = 20
        chartView.layer.masksToBounds = true

    }
    
    func myPlantUpdate(){
        for plant in userPlants {
            if plant.name == myPlant!.name {
                myPlant = plant
            }
        }
    }
 
    //다이어리 생성 화면으로 이동
    @IBAction func plusButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        let alertController = UIAlertController(title: "다이어리 추가", message: nil, preferredStyle: .actionSheet)//action sheet 이름을 choose imageSource로 스타일은 actionsheet
        
        requestCameraPermission()
        requestGalleryPermission()

        
        //다음 세개를 action sheet에 추가할 것
        //cancel로 정하면 맨 밑에 생기고 default면 그냥 위에 생김
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self

        //카메라로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            let cameraAction = UIAlertAction(title: "카메라 선택하기",style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker,animated: true,completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        //사진 앨범으로 추가하기
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            
            switch photoAuthorizationStatus {
            case .limited:
                showLimittedAccessUI()

                
                let photoLibraryAction = UIAlertAction(title: "사진 선택하기", style: .default, handler: { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker,animated: true,completion: nil)
                    })
                    alertController.addAction(photoLibraryAction)
                
                //팝오버로 보여준다
                alertController.popoverPresentationController?.sourceView = sender as! UIButton
                present(alertController, animated: true, completion: nil)
                break
            case .authorized:                let photoLibraryAction = UIAlertAction(title: "사진 선택하기", style: .default, handler: { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker,animated: true,completion: nil)
                    })
                    alertController.addAction(photoLibraryAction)
                
                //팝오버로 보여준다
                alertController.popoverPresentationController?.sourceView = sender as! UIButton
                present(alertController, animated: true, completion: nil)
                break
            case .denied:
                setAuthAlertAction()
                break
            case .notDetermined:
                requestGalleryPermission()
                break
            
                
            default: break
            }
            
        }
        
        
    }

    
    //사용자가 제한한 사진의 개수
    func showLimittedAccessUI() {
        let photoCount = PHAsset.fetchAssets(with: nil).count
    }
    
    //권한 설정
    func setAuthAlertAction() {
        let authAlertController: UIAlertController
        authAlertController = UIAlertController(title: "갤러리 권한 요청", message: "사진 기능을 사용하기 원하시다면 '사진' 접근권한을 허용해야 합니다.", preferredStyle: UIAlertController.Style.alert)
        let getAuthAction: UIAlertAction
        getAuthAction = UIAlertAction(title: "권한 허용", style: UIAlertAction.Style.default, handler: {_ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
            
        })
        
        authAlertController.addAction(getAuthAction)
        self.present(authAlertController, animated: true, completion: nil)
    }
    
    
    //아래는 컬랙션 뷰의 설정
         func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (myPlant?.diarylist.count)!
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiaryCollectionViewCell
            if let userDiary = myPlant?.diarylist[indexPath.row]{
                cell.update(info: userDiary)
                    }
            return cell
        }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
        //10으로하면 12 아이폰에서 다시 깨지길래 12로 바꿔뒀어
        let width  = (diaryCollectionView.frame.width-12)/3
            return CGSize(width: width, height: width)
        }

    
    //이미지 피커 설정
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //이미지를 선택했으면 imageView에 보여주는 함수
        guard let sImage = info[.originalImage] as? UIImage else { return }
  
        
        
            selectedImage = sImage
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            dateString = formatter.string(from: Date())
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "pickImageSegue", sender: self)
      
    }
    
    
    
   //식물 정보 수정버튼이 눌리게 되면
    @IBAction func editButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            showAlert()
            return
        }
        let alert = UIAlertController(title: "식물 관리하기", message: "당신의 식물을 관리하세요", preferredStyle: .actionSheet)

        //수정하기 버튼
            alert.addAction(UIAlertAction(title: "수정하기", style: .default , handler:{ (UIAlertAction) in
                self.performSegue(withIdentifier: "editPlantSegue", sender: MyPlantViewController.self)
            }))

        //삭제하기 버튼
        alert.addAction(UIAlertAction(title: "삭제하기", style: .destructive , handler:{ [self] (UIAlertAction)in
                //해당 식물 삭제하기
                for i in 0...(userPlants.count-1) {
                    if(userPlants[i].name == self.myPlant!.name){
                        deleteUserPlantDiaryImage(title: "\(self.myPlant!.name)")
                        userPlants.remove(at: i)
                        deleteUserPlantImage(title: "\(self.myPlant!.name)")
                        break
                    }
                    
                }
                
                //삭제하고 저장하기
                saveUserInfo(user: myUser)
                saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                self.performSegue(withIdentifier: "unwindToUserPlants", sender: MyPlantViewController.self)
            }))
            
        
        //해제 버튼
            alert.addAction(UIAlertAction(title: "취소하기", style: .cancel, handler:{ (UIAlertAction)in
            }))

            self.present(alert, animated: true, completion: {
            })
    
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "로그인이 필요한 서비스입니다", message: "로그인 후 이용바랍니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //이 화면으로 돌아올 수있게 하는 길 만들어두기
    @IBAction func unwindToMyPlant(_ unwindSegue: UIStoryboardSegue) {
        //다이어리를 삭제했었던 경우
        if(isDeleteDiary == true){
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == myPlant!.name){
                    userPlants[i] = myPlant!
                }
            }
        }
        
        //이건 뭐지 - 식물 정보 수정하고 save하고 돌아온 경우인가
        else{
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == myPlant!.name){
                   myPlant = userPlants[i]
                }
            }
        }
        diaryCollectionView.reloadData()
      
    }
    
    
    @IBAction func unwindToSetting(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        if let sourceVC = sourceViewController as? EditUserPlantTableViewController {
            myPlant = sourceVC.editPlant
            updateUI()
            diaryCollectionView.reloadData()

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        
        if let detailVC = segue.destination as? MyDiaryViewController,let cell = sender as? UICollectionViewCell,
           let indexPath =  diaryCollectionView.indexPath(for: cell) {
            detailVC.diary = myPlant?.diarylist[indexPath.item]
            detailVC.myplant = myPlant
            detailVC.index = indexPath.item
        }
    
        
        if segue.identifier == "pickImageSegue"{
            if let detailVC = segue.destination as? WriteDiaryViewController{
                detailVC.image = selectedImage!
                detailVC.userplant = myPlant
                detailVC.isEdit = false
                detailVC.imageDate = dateString
                
            }
        }
        
        if segue.identifier == "editPlantSegue"{
            if let detailVC = segue.destination as? EditUserPlantTableViewController{
                
                detailVC.editPlant = myPlant
                
            }
        }
        
    }

}

