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

      
        var date = Date()
        var cal = Calendar.current
        var currentYear : Int = cal.component(.year, from: date)
        var currentMonth : Int = cal.component(.month, from: date)
        var currentDay : Int = cal.component(.day, from: date)
        var currentHour : Int = cal.component(.hour,from:date)
        var currentMinute : Int = cal.component(.minute, from: date)

     
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeCollectionViewCell", for: indexPath) as! NoticeCollectionViewCell

       cell.TitleLabel.text! = boardList[indexPath.row].title!
     // cell.TimeLabel.text! = boardList[indexPath.row].date!
      
        var testStr1 = boardList[indexPath.row].date!
        var testDisassemble: [Character] = []
        for i in 0..<testStr1.count {
            testDisassemble.append(testStr1[testStr1.index(testStr1.startIndex, offsetBy: i)])
        }
        
        var Year : Int!
        var Month : Int!
        var Week : Int!
        var Day : Int!
        var Hour : Int!
        var Minute : Int!
        Year = 0;
        Month = 0;
        Week = 0;
        Day = 0;
        Hour = 0;
        Minute = 0;
        
        for i in 0..<4{ //년도 출력
            let char:Character = (testDisassemble[i])
            if  let number = Int(String(char)){
                if(i==0)
                {
                    Year+=number*1000;
                }
                if(i==1)
                {
                     Year+=number*100;
                }
                if(i==2)
                {
                     Year+=number*10;
                }
                if(i==3)
                {
                     Year+=number;
                }
            }
           
        }
        for i in 5..<7{//달 출력
            let char:Character = (testDisassemble[i])
            if let number = Int(String(char)){
                if(i==5)
                {
                    Month+=number*10;
                }
                if(i==6)
                {
                    Month+=number;
                }
            }
        }
        
        for i in 8..<10{ //요일출력
            let char:Character = (testDisassemble[i])
            if let number = Int(String(char)){
                if(i==8)
                {
                    Day+=number*10;
                }
                if(i==9)
                {
                    Day+=number;
                }
            }
        }
      
        for i in 11..<13{ //시간 출력
            let char:Character = (testDisassemble[i])
            if let number = Int(String(char)){
                if(i==11)
                {
                    Hour+=number*10;
                }
                if(i==12)
                {
                    Hour+=number;
                }
            }
        }
        
        for i in 14..<16{
            let char:Character = (testDisassemble[i])
            if let number = Int(String(char)){
                if(i==14)
                {
                    Minute+=number*10;
                }
                if(i==15)
                {
                    Minute+=number;
                }
            }
        }
        
        print(Year, Month, Day, Hour, Minute)
        
        
        
        if((currentYear-Year>=1))
        {
            cell.TimeLabel.text! = "\(currentYear-Year)년 전"
        }
       else
            if((currentYear-Year<1)&&(currentMonth-Month>=1))
        {
            cell.TimeLabel.text! = "\(currentMonth-Month)달 전"
        }
            else
                if((currentYear-Year<1)&&(currentMonth-Month<1)&&(currentDay-Day)>=7)
                {
                    cell.TimeLabel.text! = "\((currentDay-Day)/7)주 전"
                }
                    
        else
            if((currentYear-Year<1)&&(currentMonth-Month<1)&&(currentDay-Day)>=1&&(currentDay-Day)<7)
        {
            cell.TimeLabel.text! = "\(currentDay-Day)일 전"
        }
        else
            if((currentYear-Year<1)&&(currentMonth-Month<1)&&(currentDay-Day<1)&&(currentHour-Hour>=1))
        {
            cell.TimeLabel.text! = "\(currentHour-Hour)시간 전"
        }
        else
            if((currentYear-Year<1)&&(currentMonth-Month<1)&&(currentDay-Day<1)&&(currentHour-Hour<1))
        {
            cell.TimeLabel.text! = "\(currentMinute-Minute)분 전"
        }
    
        
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
        DNvC.titleTime = boardList[indexPath.row].date!
        
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
                    let date = item["date"] as? String ?? ""
                    let fileName = item["fileName"] as? [String] ?? [""]
                    let obj = NoticeResult.init(content_serial_id: content_serial_id, title: title, content: content, department: department, date: date, fileName: fileName)
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

