//
//  PhoneDirectoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit





class PhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate  {
    
    let prof = ["이","박"]
    let phone = ["010-1234-5678","010-1234-1234"]
    let email = ["gudwn@naver.com","gudwn@inu.ac.kr"]
    let lab = ["갯벌타워","글로벌어학원"]
    let memo = ["퇴근","하고싶다"]
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var PhoneBookTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prof.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as! DirectoryTableViewCell
        
        cell.ProfNameLabel.text! = prof[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "PhoneBookViewDetail") as? PhoneBookViewDetail{
            dvc.GetName = prof[indexPath.row]
            dvc.GetNum = phone[indexPath.row]
            dvc.GetEmail = email[indexPath.row]
            dvc.GetLab = lab[indexPath.row]
            dvc.GetMemo = memo[indexPath.row]
            
            self.navigationController?.show(dvc, sender: nil)
        }
        
    }
    
}
/*
    // 서치바
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filtered = searchText.isEmpty ? names : names.filter({(dataString : String) -> Bool in
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

