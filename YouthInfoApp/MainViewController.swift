//
//  MainViewController.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/11/03.
//

import UIKit
import ImageSlideshow

// 화면에 보여줄 이미지 파일 이름을 images 배열에 저장
//var images = [ "mainbanner01.png", "mainbanner02.png" ]


class MainViewController: UIViewController {
    
    
    func setSearchControllerUI() {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        // set placeholder
        let placeholder = "검색창입니다"
        searchController.searchBar.placeholder = placeholder
        // searchController가 검색하는 동안 네비게이션에 가려지지 않도록
        searchController.hidesNavigationBarDuringPresentation = false
        // searchBar cancel button text change (cancel을 취소로 텍스트 변경)
//        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
      
    }
    
    
    // 빈 화면 터치 시 키보드 내려가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    //slideshow
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    //slideshow
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    //slideshow
    let localSource = [BundleImageSource(imageString: "img1"), BundleImageSource(imageString: "img2"), BundleImageSource(imageString: "img3"), BundleImageSource(imageString: "img4")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //slideshow
        slideshow.slideshowInterval = 5.0
//        slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
//        let pageIndicator = UIPageControl()
//        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
//        pageIndicator.pageIndicatorTintColor = UIColor.black
//        slideshow.pageIndicator = pageIndicator
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
//        slideshow.activityIndicator = DefaultActivityIndicator()
//        slideshow.delegate = self
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)
        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.didTap))
//        slideshow.addGestureRecognizer(recognizer)
        //slideshow end

        // Do any additional setup after loading the view.
        
        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
//        pageControl.numberOfPages = images.count
//        // 페이지 컨트롤의 현재 페이지를 0으로 설정
//        pageControl.currentPage = 0
//        // 페이지 표시 색상을 밝은 회색 설정
//        pageControl.pageIndicatorTintColor = UIColor.lightGray
//        // 현재 페이지 표시 색상을 검정색으로 설정
//        pageControl.currentPageIndicatorTintColor = UIColor.blue
//        imgView.image = UIImage(named: images[0])
    }
    
    //slideshow
//    @objc func didTap() {
//        let fullScreenController = slideshow.presentFullScreenController(from: self)
//        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
//        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
//        print("didTap")
//    }
    // 페이지가 변하면 호출됨
//    @IBAction func pageChanged(_ sender: Any) {
//        // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
//        imgView.image = UIImage(named: images[pageControl.currentPage])
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
//        print("current page:", page)
    }
}
