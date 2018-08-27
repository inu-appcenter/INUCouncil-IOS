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
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBAction func BackButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
  
    @IBOutlet weak var MainView: UIView!
    
    class Contents {
        var name: String?
    }
    class Image {
        var name: String?
        
    }
    class Searchable{
        var image = Image()
        var contents = Contents()
    }
 
    var titlelabel = ""
    var timelabel = ""
    var imageArr = [""]
    var contents = [""]
    var places = ["seoul","incheon","busan","bupyeong","city"]
    var searchable = [Searchable]()
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchable.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchable[indexPath.row].contents.name != nil{
            let cell: ContentsCell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
            cell.ContentsView.text = searchable[indexPath.row].contents.name
            return cell
        } //첫번째 셀 보여줌
        else{
            let cell: ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
         //   cell.ContentsImage.image = image[indexPath.row] as! UIImage
           
            return cell
        } //두번째 셀 보여줌
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchable[indexPath.row].contents.name != nil{
            return UITableViewAutomaticDimension
        }else{
            return 266
        }
    }
    
    @IBOutlet weak var tableview: UITableView!
    
  /*
    var getTitle = String()
    var getTime = String()
    var getContents = String()
    //var getImage = UIImage()
*/
override func viewDidLoad() {
    
    super.viewDidLoad()
    
   MainView.layer.cornerRadius = 10
    tableview.delegate = self
    tableview.dataSource = self
    populate_array()
    //   imageArr = [UIImage(named: "다현")!,UIImage(named: "Icon")!]
  
   NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
    statusBarView.backgroundColor = statusBarColor
    view.addSubview(statusBarView)
   
    TitleLabel.text! = titlelabel
    TimeLabel.text! = timelabel
  
}


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  
}

   
class CustomNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
    }
}


    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
    
    func populate_array() {
        
        for each in contents{
            var contents = Contents()
            contents.name = each
            var element = Searchable()
            element.contents = contents
            self.searchable.append(element)
        }
        for each in places{
            var image = Image()
            image.name = each
            var element = Searchable()
            element.image = image
            self.searchable.append(element)
        }
        tableview.reloadData()
    }
    //첫번째 셀 크기 텍스트 길이에 따라 유동적으로 변함.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "";
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
    }
}
