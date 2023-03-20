//
//  WelcomeVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import UIKit

class WelcomeVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logoVw: UIView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var websiteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        initialSetUp()
    }
    
    //MARK: - IBActions
    @IBAction func continueBtnClk(_ sender: UIButton) {
        self.openChatVC()
    }
    
    @IBAction func websiteBtnClk(_ sender: UIButton) {
        self.openWebsite()
    }
    
    //MARK: - Methods
    func initialSetUp() {
        logoVw.setCornerRadius(radius: 10)
        continueBtn.setCornerRadius(radius: continueBtn.layer.bounds.height/2)
        websiteBtn.setCornerRadius(radius: websiteBtn.layer.bounds.height/2)
        websiteBtn.setBorder(borderWidth: 1, color: UIColor(named: "txt_green")!)
    }
    
    func openWebsite() {
        guard let url = URL(string: "https://openai.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    func openChatVC() {
        let chatVC = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
