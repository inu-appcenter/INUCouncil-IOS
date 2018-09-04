//
//  PhoneDirectoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class Prof {
    let name : String
    let phone : String
    let email : String
    let lab : String
    let memo : String
    
    init(name : String, phone: String, email: String, lab: String, memo: String){
        self.name = name
        self.phone = phone
        self.email = email
        self.lab = lab
        self.memo = memo
    }
}


class PhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var PhoneBookTableView: UITableView!
    
    var profArray = [Prof]()
    var currentProfArray = [Prof]() //Upload Table

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProf()
        setUpSearchBar()
        PhoneBookTableView.layer.cornerRadius = 10
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    private func setUpProf() {
        profArray.append(Prof(name: "Lim", phone: "4321", email: "gudwn@naver.com", lab: "korea", memo: "hello"))
        profArray.append(Prof(name: "Lee", phone: "1234", email: "gudwn@naver.com", lab: "korea", memo: "hello"))
           profArray.append(Prof(name: "Kim", phone: "3421", email: "gudwn@naver.com", lab: "korea", memo: "hello"))
           profArray.append(Prof(name: "Park", phone: "4321", email: "gudwn@naver.com", lab: "korea", memo: "hello"))
        profArray.append(Prof(name: "Lim", phone: "4321", email: "gudwn@naver.com", lab: "korea", memo: "hello"))
        currentProfArray = profArray
    }
    
    private func setUpSearchBar() {
        SearchBar.delegate = self
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentProfArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as? DirectoryTableViewCell else {
            return UITableViewCell()
        }
        cell.ProfNameLabel.text = currentProfArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "PhoneBookViewDetail") as? PhoneBookViewDetail{
            dvc.GetName = profArray[indexPath.row].name
            dvc.GetNum = profArray[indexPath.row].phone
            dvc.GetEmail = profArray[indexPath.row].email
            dvc.GetLab = profArray[indexPath.row].lab
            dvc.GetMemo = profArray[indexPath.row].memo
            self.navigationController?.show(dvc, sender: nil)
        }
        
    }
 
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentProfArray = profArray
            PhoneBookTableView.reloadData()
            return
        }
        currentProfArray = profArray.filter({Prof -> Bool in
        guard let text = searchBar.text else {return false}
       return Prof.name.contains(text)
     })
     PhoneBookTableView.reloadData()
    }
}






