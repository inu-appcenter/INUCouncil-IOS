//
//  NoticeView.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

struct NoticeCellData {
    let image : UIImage?
    let message : String?
    
}
class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    
    @IBOutlet weak var NoticeTableView: UITableView!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var MajorSearchBar: UISearchBar!
    
    @IBAction func InsertButtonClick(_ sender: Any) {
    }
    var isShowed: Bool = false
    
    var name:NSArray = []
    var imageArr:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = ["image1", "image2"]
        imageArr = [UIImage(named: "다현")!,UIImage(named: "Icon")!]
        addNoti()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        MajorSearchBar.backgroundImage = UIImage()
        MajorSearchBar.setValue("취소", forKey: "_cancelButtonText")
    }
    
    func addNoti() {
    NotificationCenter.default.addObserver(self, selector: #selector(NoticeViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NoticeViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isShowed{
            isShowed = true
            self.MajorSearchBar.setShowsCancelButton(true, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //테이블 뷰 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticecell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell") as! NoticeTableViewCell
        noticecell.NoticeImage.image = imageArr[indexPath.row] as? UIImage //tableviewcell에 지정한 이미지랑 라벨
        noticecell.NoticeLabel.text! = name[indexPath.row] as! String
        return noticecell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "DetailNoticeViewController") as! DetailNoticeViewController
        DvC.getImage = imageArr[indexPath.row] as! UIImage
        DvC.getname = name[indexPath.row] as! String
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    }
    

