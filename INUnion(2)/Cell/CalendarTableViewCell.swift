//
//  CalendarTableViewCell.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 22..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ContentsLabel: UILabel!
    @IBOutlet weak var CardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
CardView.backgroundColor = UIColor.white
       
        CardView.layer.cornerRadius=10
        CardView.layer.masksToBounds = false
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
