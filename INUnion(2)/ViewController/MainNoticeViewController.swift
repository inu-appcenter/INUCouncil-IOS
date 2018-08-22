//
//  TestViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class MainNoticeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var BoardSearchBar: UISearchBar!
    @IBOutlet weak var CollectionView: UICollectionView!
   
    var images = ["다현","Icon","settings","PlusButton"]
    override func viewDidLoad() {
        super.viewDidLoad()
       self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        BoardSearchBar.backgroundImage = UIImage()
        BoardSearchBar.setValue("취소", forKey: "_cancelButtonText")
        CollectionView.layer.cornerRadius = 10
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoticeCollectionViewCell", for: indexPath) as! NoticeCollectionViewCell
        cell.MyImageView.image = UIImage(named: images[indexPath.row])
        cell.contentView.layer.cornerRadius = 10
       cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor(red: 248, green: 249, blue: 250, alpha: 1).cgColor
       cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
//Detail Notice로 넘어가는 함수
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle:nil)
        let DNvC = Storyboard.instantiateViewController(withIdentifier: "DetailNoticeViewController") as! DetailNoticeViewController
        DNvC.getImage = imageArr[indexPath.row] as! UIImage
        DNvC.getname = name[indexPath.row] as! String
self.navigationController?.pushViewController(DNvC, animated: true)
    }*/
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
