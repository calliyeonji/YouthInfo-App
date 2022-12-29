//
//  JobcafeTableViewController.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/10/29.
//

import UIKit

class JobcafeTableViewController: UITableViewController {
    
    //page btnPrev, btnNext, jobCafeSearchBar 아울렛 연결
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var jobCafeSearchBar: UISearchBar!
    
    var rootResult: JobCafeOpenInfo?
    var cafes: [Info] = [] //카페data
    var apiKey = "4f55454b7579656f39306a72756755" //key값
//    var page //페이지 전환을 위한 변수 선언
    var startPage:Int = 0
    var endPage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 190 //table 높이값
//        jobCafeSearchBar.delegate = self
        
//        page = 1
//        search(with: "서울특별시", page: page)
        startPage = 1
        endPage = 10
        search(startPage,endPage)
        
//        cafeAPI()
    }
    
    //cafeAPI 호출
//    func cafeAPI() {
//        let str = "http://openapi.seoul.go.kr:8088/\(apiKey)/json/jobCafeOpenInfo/1/50"
//        guard let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//              let url = URL(string: strURL) else { return }
//
//        let request = URLRequest(url: url)
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            let decoder = JSONDecoder()
//            guard let data = data else { return }
//
//            do{
//                let result = try decoder.decode(RootData.self, from: data)
//                self.rootResult = result.jobCafeOpenInfo
//                self.cafes = self.rootResult!.row
//
//                print(self.cafes)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
//            } catch {
//                print("파싱실패")
//            }
//        }
//        task.resume()
//    }
    
    func search(_ startPage:Int,_ endPage:Int) {
        
        let str = "http://openapi.seoul.go.kr:8088/\(apiKey)/json/jobCafeOpenInfo/\(startPage)/\(endPage)/"

        guard let url = URL(string: str) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let decoder = JSONDecoder()
            guard let data = data else { return }
            do {
                let parser = try decoder.decode(RootData.self, from: data)
                self.rootResult = parser.jobCafeOpenInfo
                self.cafes = self.rootResult!.row
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.btnNext.isEnabled = (endPage <= parser.jobCafeOpenInfo.list_total_count)
//                    self.btnNext.isEnabled = !parser.jobCafeOpenInfo.list_total_count
                }
            } catch {
                print("파싱실패")
            }
        }
        task.resume()
        btnPrev.isEnabled = startPage > 1
        
    }

    
    
    @IBAction func btnPrev(_ sender: Any) {
//        page -= 1
////        search(with: "서울특별시", page: page)
//        search(with: jobCafeSearchBar.text, page: page)
        startPage -= 10
        endPage -= 10
        search(startPage,endPage)
    }
//
    @IBAction func btnNext(_ sender: Any) {
//        page += 1
//        search(with: jobCafeSearchBar.text, page: page)
////        search(with: "서울특별시", page: page)
        ///startPage -= 10
        startPage += 10
        endPage += 10
        search(startPage,endPage)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cafes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cafe = cafes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cafecell", for: indexPath)
        //URL->URLRequest->URLSession->session.dataTask-> handler(data)
        let imageView = cell.viewWithTag(10) as? UIImageView

        if let url = URL(string: cafe.FILE_NM){
            let request = URLRequest(url: url)
            let session = URLSession.shared
            session.dataTask(with: request){ data, _, error in
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        imageView?.image = image
                    }
                }
            }.resume()
        }

        let lblTitle1 = cell.viewWithTag(1) as? UILabel
        lblTitle1?.text = cafe.CAFE_NM //카페명

        let lblTitle2 = cell.viewWithTag(2) as? UILabel
        lblTitle2?.text = cafe.SMPL_INTRO //간략소개

        let lblTitle3 = cell.viewWithTag(3) as? UILabel
        lblTitle3?.text = cafe.SPACE_INFRO //공간소개

        let lblTitle4 = cell.viewWithTag(4) as? UILabel
        lblTitle4?.text = "이용시간: \(cafe.USE_DT)" //이용시간

        let lblTitle5 = cell.viewWithTag(5) as? UILabel
        lblTitle5?.text = "휴무일: \(cafe.HOLI_DD)" //휴무일 \n 쓰면 다음줄로 가능

        let lblTitle6 = cell.viewWithTag(6) as? UILabel
        lblTitle6?.text = "시설안내: \(cafe.FACLT_INFO1)" //시설안내

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cafecell", for: indexPath)
//        let cafe = cafes[indexPath.row]
//
//
//        let lblTitle1 = cell.viewWithTag(1) as? UILabel
//                    lblTitle1?.text = cafe.CAFE_NM //카페명
//
//                    let lblTitle2 = cell.viewWithTag(2) as? UILabel
//                    lblTitle2?.text = cafe.SMPL_INTRO //간략소개
//
//                    let lblTitle3 = cell.viewWithTag(3) as? UILabel
//                    lblTitle3?.text = cafe.SPACE_INFRO //공간소개
//
//                    let lblTitle4 = cell.viewWithTag(4) as? UILabel
//                    lblTitle4?.text = "이용시간: \(cafe.USE_DT)" //이용시간
//
//                    let lblTitle5 = cell.viewWithTag(5) as? UILabel
//                    lblTitle5?.text = "휴무일: \(cafe.HOLI_DD)" //휴무일 \n 쓰면 다음줄로 가능
//
//                    let lblTitle6 = cell.viewWithTag(6) as? UILabel
//                    lblTitle6?.text = "시설안내: \(cafe.FACLT_INFO1)" //시설안내
//
//        // Configure the cell…
//
//        return cell
//    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
   
     

}
