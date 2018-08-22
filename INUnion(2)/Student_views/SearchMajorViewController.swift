//
//  SearchMajor.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//
import UIKit

class SearchMajorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var isShowed: Bool = false
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        tableView.dataSource = self
        tableView.delegate = self
        
        filtered = departments
        
        addNoti()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(SearchMajorViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchMajorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isShowed{
            isShowed = true
            self.SearchBar.setShowsCancelButton(true, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    let departments = ["건설환경공학부", "경영학부", "경제학과", "공연예술학과", "국어교육과", "국어국문학과",
                       "글로벌물류학과", "기계공학과", "도시건축학부", "도시공학과", "도시시설관리공학과","도시행정학과",
                       "독어독문학과", "디자인학부", "러시아통상학과", "메카트로닉스공학과", "무역학부", "문헌정보학과", "물리학과",
                       "미국통상학과", "바이오경영학과", "법학부", "불어불문학과", "사회복지학과", "산업경영공학과", "생명공학부",
                       "생명과학부", "세무회계학과", "소비자·아동학과", "수학과", "수학교육과", "신문방송학과", "신소재공학과",
                       "안전공학과", "에너지화학공학과", "역사교육과", "영어교육과", "영어영문학과", "운동건강과학부", "유아교육과",
                       "영어교육과", "영어영문학과", "유아교육과", "윤리교육과", "융합시스템공학과", "일본통상학과", "일어교육과",
                       "일어일문학과", "임베디드시스템공학과", "일본통상학과", "전기공학과", "전자공학과", "정보전자공학과", "정보통신공학과",
                       "정치외교학과", "조형예술학부", "중국통상학과", "중어중국학과", "창의인재개발학과", "체육교육과", "체육학부", "컴퓨터공학부",
                       "패션산업학과", "해양학과", "행정학과", "화학과"]
    
    var filtered: [String]! // 검색결과 저장
    
    // 테이블뷰 코드
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return departments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if searchActive {
            cell.textLabel?.text = filtered[indexPath.row]
        } else{
            cell.textLabel?.text = departments[indexPath.row]
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if searchActive{
            PersonInfo.FirstMajor = filtered[indexPath.row]
            MajoruserDefault.set(PersonInfo.FirstMajor, forKey: "FirstMajor")
        } else{
            PersonInfo.FirstMajor = departments[indexPath.row]
            MajoruserDefault.set(PersonInfo.FirstMajor, forKey: "FirstMajor")
        }
        
    }
    
    
    // 서치바 코드
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = searchText.isEmpty ? departments : departments.filter({(dataString : String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isShowed = false
        searchActive = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    class CustomNavController: UINavigationController
    {
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
    }
    
}
