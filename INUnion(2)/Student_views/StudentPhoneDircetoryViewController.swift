//
//  StudentPhoneDircetoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 13..
//  Copyright © 2018년 이형주. All rights reserved.
//


import UIKit

class StudentPhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    let studentnames = ["이교수", "김교수"]
    let studentphones = ["0101234","12345678"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (studentnames.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DirectoryTableViewCell
        
         cell.PhoneLabel.text = studentphones[indexPath.row]
         cell.NameLabel.text = studentnames[indexPath.row]
        return (cell)
    }
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        SearchBar.backgroundImage = UIImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
