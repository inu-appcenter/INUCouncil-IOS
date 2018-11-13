//
//  TestViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit
import Device
import Kingfisher


class MainNoticeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var BoardSearchBar: UISearchBar!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var MajorLabel: UILabel!
   
    @IBAction func WfiteButtonClicked(_ sender: Any) {

    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?

    var boardList:[NoticeResult] = []{
        didSet {
            if self.CollectionView != nil {
                self.CollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        boardList.removeAll()
        model?.DirectoryList(department: self.appDelegate.department!)
        MajorLabel.text! = self.appDelegate.department!
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        /*let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)*/
       
        
        BoardSearchBar.backgroundImage = UIImage()
        BoardSearchBar.setValue("취소", forKey: "_cancelButtonText")
        CollectionView.layer.cornerRadius = 4
        CollectionView.layer.backgroundColor = UIColor.clear.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "공지사항"
        super.viewWillAppear(animated)
        model = NetworkModel(self)
        boardList.removeAll()
        model?.boardList(department: self.appDelegate.department!)
        self.navigationController?.navigationBar.tintColor = UIColor.white
       
        
        BoardSearchBar.backgroundImage = UIImage()
        BoardSearchBar.setValue("취소", forKey: "_cancelButtonText")
        CollectionView.layer.cornerRadius = 4
        CollectionView.layer.backgroundColor = UIColor.clear.cgColor

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Device.size() {
        case .screen3_5Inch, .screen4Inch:
            return CGSize(width: 300, height: 68)
        case .screen4_7Inch, .screen5_8Inch:
            return CGSize(width: 348.5, height: 254.6)
        case .screen5_5Inch:
            return CGSize(width: 382, height: 279)
        case .screen7_9Inch:
            return CGSize(width: 500, height: 114)
        case .screen10_5Inch:
            return CGSize(width: 900, height: 205)
        case .screen12_9Inch:
            return CGSize(width: 1000, height: 228)
        default:
            return CGSize(width: 700, height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeCollectionViewCell", for: indexPath) as! NoticeCollectionViewCell

        cell.TitleLabel.text! = boardList[indexPath.row].title!
        
        cell.TimeLabel.text! = boardList[indexPath.row].timeSave!
      
        
        for i in 0..<(boardList[indexPath.row].fileName?.count)!{
     
            let logo = "http://117.16.231.66:7001/imgload/\(boardList[indexPath.row].fileName![i])"
            let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            switch i{
            case 0:
                cell.MyImageView.isHidden = false
                cell.MyImageView.kf.setImage(with: resource)
                break
            case 1:
                cell.MyImageView2.isHidden = false
                cell.MyImageView2.kf.setImage(with: resource)
                break
            case 2:
                cell.MyImageView3.isHidden = false
                cell.MyImageView3.kf.setImage(with: resource)
                break
            case 3:
                cell.MyImageView4.isHidden = false
                cell.MyImageView4.kf.setImage(with: resource)
                break
            case 4:
                cell.PlusLabel.isHidden = false
                cell.PlusLabel.text! = "+1"
                cell.MyImageView.isHidden = false
                cell.MyImageView2.isHidden = false
                cell.MyImageView3.isHidden = false
                cell.MyImageView4.isHidden = false
                break
            case 5:
                cell.PlusLabel.isHidden = false
                cell.PlusLabel.text! = "+2"
                cell.MyImageView.isHidden = false
                cell.MyImageView2.isHidden = false
                cell.MyImageView3.isHidden = false
                cell.MyImageView4.isHidden = false
                break
           
            default:
                cell.PlusLabel.isHidden = false
                cell.PlusLabel.text! = "+3"
                cell.MyImageView.isHidden = false
                cell.MyImageView2.isHidden = false
                cell.MyImageView3.isHidden = false
                cell.MyImageView4.isHidden = false
                break
            }
            
        }
        cell.ContentsText.text! = boardList[indexPath.row].content!
        
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor(red: 248, green: 249, blue: 250, alpha: 1).cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect:
            cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.isSelected = false
    if let DNvC = storyboard?.instantiateViewController(withIdentifier: "DetailNoticeViewController") as? DetailNoticeViewController{
        DNvC.boardId = boardList[indexPath.row].content_serial_id!
        DNvC.titleName = boardList[indexPath.row].title!
        DNvC.titleTime = boardList[indexPath.row].timeSave!
        
    self.navigationController?.show(DNvC, sender: nil)
    }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
}


extension MainNoticeViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "boardListSuccess" {
            print(resultdata)
            
            var temp: [NoticeResult] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let content_serial_id = item["content_serial_id"] as? Int ?? 0
                    let title = item["title"] as? String ?? ""
                    let content = item["content"] as? String ?? ""
                    let department = item["department"] as? String ?? ""
                    let timeSave = item["timeSave"] as? String ?? ""
                    let fileName = item["fileName"] as? [String] ?? [""]
                    let obj = NoticeResult.init(content_serial_id: content_serial_id, title: title, content: content, department: department, timeSave: timeSave, fileName: fileName)
                    temp.append(obj)
                }
            }
            
            self.boardList = temp
            
        }
    }
    
    func networkFail(code: String) {
        if(code == "boardListError") {
            print("실패하였습니다.")
        }
        
    }
}

