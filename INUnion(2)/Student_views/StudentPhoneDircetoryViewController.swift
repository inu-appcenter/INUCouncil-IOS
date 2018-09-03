//
//  StudentPhoneDircetoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 13..
//  Copyright © 2018년 이형주. All rights reserved.
//

/*
import UIKit

class StudentPhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    let studentnames = ["이교수", "김교수"]
    let studentphones = ["0101234","12345678"]
    
    var filtered: [String]!
    
    var searchActive: Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filtered.count
        }
        else {
            return (studentnames.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DirectoryTableViewCell
        
        if searchActive{
            cell.PhoneLabel.text = filtered[indexPath.row]
            cell.NameLabel.text = filtered[indexPath.row]
        } else{
            cell.PhoneLabel.text = studentphones[indexPath.row]
            cell.NameLabel.text = studentnames[indexPath.row]
        }
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        // 테이블바를 선택했을 경우의 동작을 정의
        
    }
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var Tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        SearchBar.backgroundImage = UIImage()
        
        filtered = studentnames
        
        MajorLabel.text = PersonInfo.FirstMajor
        
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
        
        Tableview.delegate = self
        Tableview.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 서치바
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filtered = searchText.isEmpty ? studentnames : studentnames.filter({(dataString : String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        Tableview.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
}
*/
