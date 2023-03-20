//
//  UserTblVwCell.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import UIKit

class UserTblVwCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var userChatLbl: UILabel!
    @IBOutlet weak var chatLblVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chatLblVw.setCornerRadius(radius: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
