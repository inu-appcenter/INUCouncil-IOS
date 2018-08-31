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
    var imageArr :[UIImage]? = []
    var contents = [""]
    var places = ["seoul","incheon","busan","bupyeong"]
    var searchable = [Searchable]()
    
    var boardId:Int = 0
    var detailBoard: [BoardDetail] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
  
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
//            cell.ContentsImage.image = imageArr?[indexPath.row]
           
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
    
    model?.boardDetailList(department: (self.appDelegate.department)!, content_serial_id: String(boardId))
   MainView.layer.cornerRadius = 10
    tableview.delegate = self
    tableview.dataSource = self
    populate_array()
    
  

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

extension DetailNoticeViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "boardListSuccess" {
            print(resultdata)
            
            var temp: [BoardDetail] = []
            if let item = resultdata as? NSDictionary {
                    let content_serial_id = item["content_serial_id"] as? Int ?? 0
                    let title = item["title"] as? String ?? ""
                    let content = item["content"] as? String ?? ""
                    let department = item["department"] as? String ?? ""
                    let timeSave = item["timeSave"] as? String ?? ""
                    let keyNum = item["keyNum"] as? Int ?? 0
                    let fileName = item["fileName"] as? [String] ?? [""]
                    let fileKey = item["fileKey"] as? Int ?? 0
                    let obj = BoardDetail.init(content_serial_id: content_serial_id, title: title, content: content, department: department, timeSave: timeSave)
                    temp.append(obj)
                
            }
            
            self.detailBoard = temp
            
        }
    }
    
    func networkFail(code: String) {
        if(code == "boardListError") {
            print("실패하였습니다.")
        }
        
    }
}
