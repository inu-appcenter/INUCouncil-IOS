//
//  NoticeTableView.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 14..
//  Copyright © 2018년 이형주. All rights reserved.
//


import UIKit

class NoticeTableViewCell: UITableViewCell {
  
    @IBOutlet weak var NoticeLabel: UILabel!
    @IBOutlet weak var NoticeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
