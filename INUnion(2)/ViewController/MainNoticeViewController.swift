//
//  TestViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit
import Device


class MainNoticeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var BoardSearchBar: UISearchBar!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBAction func ModifyButton(_ sender: Any) {
    }
    
    var titles = ["1번","2번","3번","4번"]
    var time = ["1시간전", "2시간전", "3시간전", "4시간전"]
    var imageArr:NSArray = []
    let images = ["다현","다현","다현","다현"]
    var contents = ["1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요1번이에요","2번이에요","3번이에요","4번이에요"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        imageArr = [UIImage(named:"다현")!,UIImage(named:"Icon")!,UIImage(named:"PlusButton")!,UIImage(named:"다현")!]
        
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        BoardSearchBar.backgroundImage = UIImage()
        BoardSearchBar.setValue("취소", forKey: "_cancelButtonText")
        CollectionView.layer.cornerRadius = 4
        CollectionView.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
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
        cell.TitleLabel.text! = titles[indexPath.row]
        cell.TimeLabel.text! = time[indexPath.row]
        cell.MyImageView.image =  imageArr[indexPath.row] as? UIImage
        cell.MyImageView2.image = imageArr[indexPath.row] as? UIImage
        cell.MyImageView3.image = imageArr[indexPath.row] as? UIImage
        cell.MyImageView4.image = imageArr[indexPath.row] as? UIImage
        cell.ContentsText.text! = contents[indexPath.row]
        
        cell.contentView.layer.cornerRadius = 4
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
    

   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle:nil)
        let DNvC = Storyboard.instantiateViewController(withIdentifier: "DetailNoticeViewController") as! DetailNoticeViewController
       
       // DNvC.getImage = imageArr[indexPath.row] as! UIImage
       /* DNvC.getTitle = titles[indexPath.row]
        DNvC.getTime = time[indexPath.row]
        DNvC.getContents = contents[indexPath.row]*/
        self.navigationController?.pushViewController(DNvC, animated: true)
    }
 */
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}


