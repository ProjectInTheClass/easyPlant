//
//  SortTableViewController.swift
//  easyPlant
//
//  Created by 김유진 on 2021/04/30.
//

import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class SortTableViewController: UITableViewController, UISearchResultsUpdating,UISearchBarDelegate{
    
    var searchController = UISearchController(searchResultsController: nil)
    var nowTitle  = ""
    var plantArrayIndex = 0
    var plantArray: [Plant] = []
    var resultPlantArray: [Plant] = []
    let recognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidload")
        findArray()
        setUI()

        self.view.backgroundColor = .easyPlantPrimary
   
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode =  .never

    }
    
    
    //스크롤을 감지해서 키보드를 내리는 함수
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.removeGestureRecognizer(recognizer)
        searchController.searchBar.resignFirstResponder()


    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        recognizer.addTarget(self, action: Selector(("handleTap")))
        self.view.addGestureRecognizer(recognizer)

    }

    
    //서치바 커스텀하는 함수
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.fill()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    //UI 디자인 설정
    func setUI(){
       
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.placeholder = ""
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.layer.borderWidth = 0
        let image = self.getImageWithColor(color: UIColor.white, size: CGSize(width: 370, height: 40))
        searchController.searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        self.tableView.tableHeaderView = searchController.searchBar
       

        searchController.searchBar.layer.borderWidth = 0
        searchController.searchBar.tintColor = .easyPlantPrimary
        searchController.searchBar.backgroundColor = .easyPlantPrimary
        searchController.searchBar.layer.backgroundColor = UIColor.easyPlantPrimary.cgColor
        searchController.searchBar.barTintColor = .easyPlantPrimary
        
        searchController.searchBar.searchBarStyle = .minimal
    
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false <- deprecrated됨
        self.definesPresentationContext = true
 

    }
    
    @IBAction func saveClicked(_ sender: Any) {
        savePlantData(plantData: plantType)
    }
    
    
    //서치바에서 검색하면 새로 테이블 뷰를 세팅한다
    func updateSearchResults(for searchController: UISearchController) {
        
       
            //아직 검색한게 없다면 - 임의의 셀을 추가 -> 그냥 디자인 때문
        if searchController.searchBar.text != ""{
            
            resultPlantArray = plantArray.filter { plant in
            return
                plant.dic["cntntsSj"]!.lowercased().contains(searchController.searchBar.text!.lowercased()) || plant.dic["distbNm"]!.lowercased().contains(searchController.searchBar.text!.lowercased())
            }
            if resultPlantArray.count == 0{
                var newPlant = Plant()
                newPlant.initDic()
                newPlant.dic["cntntsSj"] = "trash"
                resultPlantArray.append(newPlant)
            }
            tableView.reloadData()
          
        }
        else {
            resultPlantArray = plantArray
            tableView.reloadData()
        }

    }
    

    //현재 식물 분류 배열이 뭔지 찾아둔다
    func findArray(){
        
        nowTitle = self.navigationItem.title!
    
        var cnt : Int = 0
        for type in plantType.type {
       
            if type == nowTitle{ break}
            cnt += 1
        }
        
        plantArrayIndex = cnt
        plantArray = plantType.plantAll[plantArrayIndex]
        resultPlantArray = plantArray
           
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return resultPlantArray.count % 2 == 0 ? resultPlantArray.count / 2 : resultPlantArray.count / 2 + 1
    }

    
    //인덱스 패스에 어떤 셀로 화면 상에 출력 되는지
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! CellTableViewCell
        
        //셀 디자인 설정
        cell.layer.borderWidth = 0
        cell.layer.backgroundColor = UIColor.easyPlantPrimary.cgColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
      
        
        //segment 값에따라 데이터 정렬
        var plants: [Plant] = []
        plants = resultPlantArray.sorted{ $0.dic["cntntsSj"]!.lowercased() < $1.dic["cntntsSj"]!.lowercased()}
       
        
        //셀에서 완쪽 항목 불러오기
        let itemLeft = plants[indexPath.row*2]
        //이미지만들어두기
        let leftImage = UIImageView()
       
        downloadPlantDataImage(imgview: leftImage, title: itemLeft.dic["cntntsSj"]!)

        cell.leftImageButton?.setImage(leftImage.image, for: .normal)
        cell.leftImageButton.imageView?.contentMode = .scaleAspectFill
        cell.leftImageButton.layer.cornerRadius = 30
        cell.leftCellView.layer.cornerRadius = 30
 
        //이미지버튼의 타이틀 설정
        cell.leftImageButton?.setTitle(itemLeft.dic["cntntsSj"], for: .normal)
        //이름버튼의 타이틀 설정
        cell.leftButton?.setTitle(itemLeft.dic["cntntsSj"], for: .normal)
        //ui 업데이트
        whiteLeftUIUpdate(cell)
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.leftButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.addTarget(self, action: #selector(SortTableViewController.leftButtonTapped(_:)), for: UIControl.Event.touchUpInside)

        //검색결과가 없다면
       
        if resultPlantArray.count == 1 && resultPlantArray[0].dic["cntntsSj"] == "trash" {
            //ui 업데이트
            greenLeftUIUpdate(cell)
            greenRightUIUpdate(cell)
            
            removeShadow(cell,"left")
            removeShadow(cell,"right")


        }
        
        
        //셀에서 오른쪽 항목 불러오기. 대신 총 항목의 개수가 홀수였던 경우는 마지막 셀의 오른쪽 항목은 생략
        if (indexPath.row*2+1) < plants.count{
            let itemRight = plants[indexPath.row*2+1]
            //이미지 설정
            
            let rightImage = UIImageView()
            rightImage.contentMode = .scaleAspectFit
          
            downloadPlantDataImage(imgview: rightImage, title: itemRight.dic["cntntsSj"]!)
        
            cell.rightImageButton?.setImage(rightImage.image, for: .normal)
            cell.rightImageButton.imageView?.contentMode = .scaleAspectFill
            cell.rightImageButton.layer.cornerRadius = 30
            cell.rightCellView.layer.cornerRadius = 30
            
            //이미지 버튼의 타이틀 설정
            cell.rightImageButton?.setTitle(itemRight.dic["cntntsSj"], for: .normal)
            //이름버튼의 타이틀 설정
            cell.rightButton?.setTitle(itemRight.dic["cntntsSj"], for: .normal)
            //ui 업데이트
            whiteRightUIUpdate(cell)
            
            //각 버튼을 눌렀을 시 호출할 함수 설정
            cell.rightButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
            cell.rightImageButton?.addTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)


        }
        else {
            //ui 업데이트
            greenRightUIUpdate(cell)
            removeShadow(cell,"right")
            
        }
            
        return cell
    }
     
    func removeShadow(_ cell: CellTableViewCell, _ dir : String){
        if dir == "right"{
            setShadowView(view: cell.rightCellView, opacity: 0.0, height: 0, shadowRadius: 0)
        }
        else{
            setShadowView(view: cell.leftCellView, opacity: 0.0, height: 0, shadowRadius: 0)
        }
    }
    
    //아래의 함수들은 모두 UI 설정 함수
    func whiteRightUIUpdate(_ cell: CellTableViewCell){
        
        cell.rightCellView.backgroundColor = UIColor.white
        cell.rightButton.backgroundColor = UIColor.white
        setShadowView(view: cell.rightCellView, height: 3, shadowRadius: 5)
    }
    
    func greenRightUIUpdate(_ cell : CellTableViewCell) {
        cell.rightImageButton?.setImage(UIImage(), for: .normal)
        cell.rightImageButton?.layer.borderWidth = 0
        cell.rightButton?.setTitle(nil, for: .normal)
        cell.rightImageButton?.setTitleColor(UIColor.easyPlantPrimary, for: .normal)

        cell.rightImageButton?.layer.borderColor = UIColor.easyPlantPrimary.cgColor

        
        cell.rightCellView.backgroundColor = UIColor.easyPlantPrimary
        cell.rightButton.backgroundColor = UIColor.easyPlantPrimary
        
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.rightButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.rightImageButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    func whiteLeftUIUpdate(_ cell: CellTableViewCell){
        cell.leftCellView.backgroundColor = UIColor.white
        cell.leftButton.backgroundColor = UIColor.white
        setShadowView(view: cell.leftCellView, height: 3, shadowRadius: 5)
    }
    
    func greenLeftUIUpdate(_ cell : CellTableViewCell) {
        cell.leftImageButton?.setImage(UIImage(), for: .normal)
        cell.leftButton?.setTitle(nil, for: .normal)
        cell.leftImageButton?.layer.borderWidth = 0
        cell.leftImageButton?.layer.borderColor = UIColor.easyPlantPrimary.cgColor
        cell.leftImageButton?.setTitleColor(UIColor.easyPlantPrimary, for: .normal)

        cell.leftCellView.backgroundColor = UIColor.easyPlantPrimary
        cell.leftButton.backgroundColor = UIColor.easyPlantPrimary
        
        //각 버튼을 눌렀을 시 호출할 함수 설정
        cell.leftButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.leftImageButton?.removeTarget(self, action: #selector(SortTableViewController.rightButtonTapped(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func leftButtonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "leftSegue", sender: sender)
    }
    @objc func rightButtonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "rightSegue", sender: sender)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let senderBut = sender as! UIButton
        
        if let vc = segue.destination as? PlantDetailViewController {
            vc.detailPlantName = senderBut.title(for: .normal)
            vc.detailPlantType = self.nowTitle
            vc.navigationItem.title = senderBut.title(for: .normal)
       
        }
    }
}

