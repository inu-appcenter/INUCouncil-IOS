//
//  DetailNoticeViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 17..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit
import Kingfisher

class  DetailNoticeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate

{
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var MainView: UIView!
 
    var titleName = ""
    var titleTime = ""
    var imageCount:Int = 0
    var imageArr :[String]? = []
    
    var boardId:Int = 0
    var detailBoard: BoardDetail?{
        didSet {
            if self.tableview != nil {
                self.tableview.reloadData()
            }
        }
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return imageCount
//            return 1
        default:
            return 0
        }
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: ContentsCell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
            cell.ContentsView.text = detailBoard?.content
            return cell
        case 1:
            let cell: ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            for i in 0..<imageCount{
                let logo = "http://117.231.66:7001/imgload/\(detailBoard!.fileName![i])"
                let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
                cell.ContentsImage.kf.setImage(with: resource)
            }
            
            
            return cell
        default:
            let cell: ContentsCell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return 266
        default:
            return 0
        }
    }
    
    
    @IBAction func rightButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "선택해", message: "쉬이발", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { (action:UIAlertAction) in
            //            self.navigationController?.popToRootViewController(animated: true)
            
        }
        let editAction = UIAlertAction(title: "수정수정정수정", style: .default) {
            (_) in
            
            return
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)

        
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
    TitleLabel.text = titleName
    TimeLabel.text = titleTime
    department.text = self.appDelegate.department
    model = NetworkModel(self)

    model?.boardDetailList(department: (self.appDelegate.department)!, content_serial_id: String(boardId))
    
   MainView.layer.cornerRadius = 10
    tableview.delegate = self
    tableview.dataSource = self

    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
    statusBarView.backgroundColor = statusBarColor
    view.addSubview(statusBarView)
}


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
  
}

    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
//                    let keyNum = item["keyNum"] as? Int ?? 0
                    let fileName = item["fileName"] as? [String] ?? [""]
//                    let fileKey = item["fileKey"] as? Int ?? 0
                let obj = BoardDetail.init(content_serial_id: content_serial_id, title: title, content: content, department: department, timeSave: timeSave,fileName:fileName)
                    temp.append(obj)
                titleName = obj.title!
                titleTime = obj.timeSave!
                imageCount = (obj.fileName?.count)!
                
                detailBoard = obj
            }
            
            
            
        }
    }
    
    func networkFail(code: String) {
        if(code == "boardListError") {
            print("실패하였습니다.")
        }
        
    }
}
