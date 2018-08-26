//
//  DetailNoticeViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 17..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class  DetailNoticeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    var people = ["Lorem , ."]
    var places = ["seoul","incheon","busan","bupyeong","city"]
    var searchable = [Searchable]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchable[indexPath.row].user.name != nil{
           
            let cell: ContentsCell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
            cell.ContentsView.text = searchable[indexPath.row].user.name
            
            return cell
        } //Display User Cell
      
        else{
            let cell: ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.ContentsLabel.text = searchable[indexPath.row].place.name
            
            return cell
        } //Display Place Cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchable[indexPath.row].user.name != nil{
            return UITableViewAutomaticDimension
        }else{
            return 254
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    
 /*   @IBAction func BackButtonClick(_ sender: Any) {
self.navigationController?.popViewController(animated: true)
    }
   */
  /*  var imageArr:NSArray = []
    var getTitle = String()
    var getTime = String()
    var getContents = String()
    //var getImage = UIImage()
*/
    
override func viewDidLoad() {
    
    super.viewDidLoad()
    
    tableview.delegate = self
    tableview.dataSource = self
    populate_array()
    
    //   imageArr = [UIImage(named: "다현")!,UIImage(named: "Icon")!]
  
  /*  NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
    statusBarView.backgroundColor = statusBarColor
    view.addSubview(statusBarView)
   
 //   TitleLabel.text! = getTitle
  //  TimeLabel.text! = getTime
  */
}

/*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  
}

   
class CustomNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
    }
}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.topItem?.title = "";
    
}
*/
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
    func populate_array() {
        
        for each in people{
            var user = User()
            user.name = each
            var element = Searchable()
           element.user = user
            self.searchable.append(element)
        }
        for each in places{
            var place = Place()
            place.name = each
            var element = Searchable()
            element.place = place
            self.searchable.append(element)
        }
        tableview.reloadData()
    }
    

    class User {
        var name: String?
    }
    class Place {
        var name: String?
    }
    
    class Searchable{
        var place = Place()
        var user = User()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
    }
}
