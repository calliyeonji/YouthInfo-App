//
//  SmallLibraryTableViewController.swift
//  YouthInfoApp
//
//  Created by yeonji on 2022/10/29.
//

import UIKit

class SmallLibraryTableViewController: UITableViewController {
    
    //page btnPrev, btnNext, searchBar 아울렛 연결
    @IBOutlet weak var btnPrev: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var rootResult: SeoulSmallLibraryInfoData?
    var librarys: [SmallLibraryInfo] = [] //작은도서관 data
    var apiKey = "6170734a6f79656f363055577a6c67" //key값
//    var startPage:Int = 0
    var endPage:Int = 0
    var startPage = 1
    //    var page //페이지 전환을 위한 변수 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 170 //table 높이값
        //        jobCafeSearchBar.delegate = self
        
        //        page = 1
        //        search(with: "서울특별시", page: page)
        startPage = 1
        endPage = 10
        smallLibraryAPI(startPage,endPage)
    }
    
    //smallLibraryAPI 호출
    func smallLibraryAPI(_ startPage:Int,_ endPage:Int) {
        
        //    func smallLibraryAPI() {
        let str = "http://openapi.seoul.go.kr:8088/\(apiKey)/json/SeoulSmallLibraryInfo/\(startPage)/\(endPage)/"
        
        guard let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: strURL) else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let data = data else { return }
            
            do{
                let parser = try decoder.decode(RootSmallLibraryData.self, from: data)
                self.rootResult = parser.SeoulSmallLibraryInfo
                self.librarys = self.rootResult!.row
                
                print(self.librarys)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.btnNext.isEnabled = (endPage <= parser.SeoulSmallLibraryInfo.list_total_count)
                }
                
            } catch {
                print("파싱실패")
            }
        }
        task.resume()
        btnPrev.isEnabled = startPage > 1
    }
    
    
    @IBAction func btnPrev(_ sender: Any) {
        startPage -= 10
        endPage -= 10
        smallLibraryAPI(startPage,endPage)
        //        smallLibraryAPI(with: searchBar.text, page: page)
        
    }
    
    @IBAction func btnNext(_ sender: Any) {
        startPage += 10
        endPage += 10
        smallLibraryAPI(startPage,endPage)
    }
    
    //    @IBAction func btnPrev(_ sender: Any) {
    //        page -= 1
    ////        search(with: "서울특별시", page: page)
    //        search(with: jobCafeSearchBar.text, page: page)
    //    }
    //
    //    @IBAction func btnNext(_ sender: Any) {
    //        page += 1
    //        search(with: jobCafeSearchBar.text, page: page)
    ////        search(with: "서울특별시", page: page)
    //    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return librarys.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let library = librarys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "librarycell", for: indexPath)
        //URL->URLRequest->URLSession->session.dataTask-> handler(data)
        
        let lblTitle1 = cell.viewWithTag(1) as? UILabel
        lblTitle1?.text = library.LBRRY_NAME //도서관명
        
        let lblTitle2 = cell.viewWithTag(2) as? UILabel
        lblTitle2?.text = library.CODE_VALUE //구명(구 이름)
        
        let lblTitle3 = cell.viewWithTag(3) as? UILabel
        lblTitle3?.text = library.ADRES //주소
        
        let lblTitle4 = cell.viewWithTag(4) as? UILabel
        lblTitle4?.text = "이용시간: \(library.OP_TIME)" //운영시간
        
        let lblTitle5 = cell.viewWithTag(5) as? UILabel
        lblTitle5?.text = "정기 휴관일: \(library.FDRM_CLOSE_DATE)" //정기 휴관일 \n 쓰면 다음줄로 가능
        
        let lblTitle6 = cell.viewWithTag(6) as? UILabel
        lblTitle6?.text = "전화번호: \(library.TEL_NO)" //전화번호
        
        return cell
    }
    
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "detail" {
        //            guard let indexPath = tableView.indexPathForSelectedRow else { return }
        //            let cafe = self.librarys[indexPath.row]
        //            let vc = segue.destination as? SmallLibraryDetailViewController
        //            vc?.strURL = cafe.HMPG_URL
        //        }
        
        
//        if segue.identifier == "detail" {
//            guard let indexPath = tableView.indexPathForSelectedRow else { return }
//            let cafe = self.librarys[indexPath.row]
//            let vc = segue.destination as? SmallLibraryDetailViewController
//            vc?.strURL = cafe.HMPG_URL
//        }
            if segue.identifier == "detail" {
                guard let indexPath = tableView.indexPathForSelectedRow else { return }
                let cafe = self.librarys[indexPath.row]
                
                let vc = segue.destination as? SmallLibraryDetailViewController
                vc?.strURL = cafe.HMPG_URL
             
                    
            }
    }
}

//extension SmallLibraryTableViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
////        startPage = 1
////        endPage = 10
//        //smallLibraryAPI(with: searchBar.text: startPage, page: endPage)
//        //smallLibraryAPI(startPage: startPage, endPage: endPage)
//        //smallLibraryAPI(with: searchBar.text, page: startPage) // 검색을할 땐 항상 페이지는 1번임.
////        smallLibraryAPI(with:)
//
//        searchBar.resignFirstResponder()
//    }
//}
