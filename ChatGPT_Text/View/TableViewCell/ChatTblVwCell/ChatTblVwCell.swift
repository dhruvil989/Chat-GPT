//
//  ChatTblVwCell.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import UIKit
import Lottie

class ChatTblVwCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var chatLbl: UILabel!
    @IBOutlet weak var logoVw: UIView!
    @IBOutlet weak var chatLblVw: UIView!
    @IBOutlet weak var animationVw: LottieAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        logoVw.setCornerRadius(radius: 2)
        chatLblVw.setCornerRadius(radius: 2)
        
        animationVw.loopMode = .loop
        animationVw.animationSpeed = 1.0
        animationVw.play()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
