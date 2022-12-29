//
//  MainViewController.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/11/03.
//

import UIKit

// 화면에 보여줄 이미지 파일 이름을 images 배열에 저장
var images = [ "mainbanner01.png", "mainbanner02.png" ]

class MainViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //페이지 컨트롤의 전체 페이지를 images 배열의 전체 개수 값으로 설정
        pageControl.numberOfPages = images.count
        // 페이지 컨트롤의 현재 페이지를 0으로 설정
        pageControl.currentPage = 0
        // 페이지 표시 색상을 밝은 회색 설정
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        // 현재 페이지 표시 색상을 검정색으로 설정
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        imgView.image = UIImage(named: images[0])
    }
    // 페이지가 변하면 호출됨
    @IBAction func pageChanged(_ sender: Any) {
        // images라는 배열에서 pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imgView에 할당
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
