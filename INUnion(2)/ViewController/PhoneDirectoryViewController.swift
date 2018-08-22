//
//  PhoneDirectory.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class PhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    let names = ["이교수", "김교수"]
    let phones = ["0101234","0104567"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (names.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DirectoryTableViewCell
 
        cell.PhoneLabel.text = phones[indexPath.row]
        cell.NameLabel.text = names[indexPath.row]
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
