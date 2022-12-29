//
//  SmallLibraryDetailViewController.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/10/30.
//

import UIKit
import WebKit

class SmallLibraryDetailViewController: UIViewController {

    var strURL:String?
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let strURL = self.strURL, let url = URL(string: strURL) {
            guard let strURL = self.strURL,
                  let url = URL(string: strURL) else { return }
            
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("파싱실패")
            
            let failurl = URL(string: "https://lib.seoul.go.kr/slibsrch/main")
            let failrequest = URLRequest(url: failurl!)
            
            self.webView.load(failrequest)
        }
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
