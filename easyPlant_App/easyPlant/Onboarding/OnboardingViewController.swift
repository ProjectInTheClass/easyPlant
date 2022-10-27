//
//  OnboardingViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/07/12.
//

import UIKit

class OnboardingViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    
    let pageList = ["page0","page1","page2","page3","page4"]
    let pageTotalNumber = 5

    var scrollWidth: CGFloat = 0.0
    var scrollHeight: CGFloat = 0.0

    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.layoutIfNeeded()
     
        updateUI()
    }

   override func viewDidLayoutSubviews() {
       scrollWidth = scrollView.frame.size.width
       scrollHeight = scrollView.frame.size.height
   }

    func updateUI() {
        nextButton.layer.cornerRadius = nextButton.frame.size.height/2
      
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<pageTotalNumber {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: pageList[index]))
            imageView.frame = CGRect(x:0,y:0,width:370,height:370)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 + 10)
          
            slide.addSubview(imageView)
            scrollView.addSubview(slide)

        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(pageTotalNumber), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = pageTotalNumber
        pageControl.currentPage = 0
    }

       //indicator
       @IBAction func pageChanged(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       }

       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           setIndiactorForCurrentPage()
       }

       func setIndiactorForCurrentPage()  {
           let page = (scrollView?.contentOffset.x)!/scrollWidth
           pageControl?.currentPage = Int(page)
       }

   }
