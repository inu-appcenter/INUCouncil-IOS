//
//  SettingTableViewCell.swift
//  INUnion(2)
//
//  Created by 동균 on 2018. 9. 2..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var settingNameLabel: UILabel!
    
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
