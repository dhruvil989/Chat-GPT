//
//  MenuVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 11/03/23.
//

import UIKit

class MenuVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var modeLbl: UILabel!
    @IBOutlet weak var gptImgVw: UIView!
    @IBOutlet weak var txtVw: UIView!
    @IBOutlet weak var knowMoreBtn: UIButton!
    @IBOutlet weak var mainVw: UIView!
    
    //MARK: - Variables
    let mode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
    }
    
    //MARK: - IBActions
    @IBAction func knowMoreBtnClk(_ sender: Any) {
        self.openWebsite(url: "https://openai.com/about")
    }
    
    @IBAction func clearConvClk(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("clearConversation"),object: nil)
    }
    
    @IBAction func darkModeClk(_ sender: Any) {
        self.setDarkMode()
    }
    
    @IBAction func redirectWebsiteClk(_ sender: Any) {
        self.openWebsite(url: "https://openai.com/")
    }
    
    @IBAction func backClk(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("back"),object: nil)
    }
    
    //MARK: - Methods
    func initalization() {
        modeLbl.text = mode ? "Light Mode" : "Dark Mode"
        
        mainVw.setCornerRadius(radius: 10)
        gptImgVw.setCornerRadius(radius: 10)
        txtVw.setCornerRadius(radius: 10)
        knowMoreBtn.setCornerRadius(radius: knowMoreBtn.layer.bounds.height/2)
        knowMoreBtn.setBorder(borderWidth: 0.5, color: UIColor(named: "txt_green")!)
    }
    
    
    func setDarkMode() {
        let mode = UserDefaults.standard.bool(forKey: "isDarkMode")
        UserDefaults.standard.setValue(!mode, forKey: "isDarkMode")
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = !mode ? .dark : .light
        }
        modeLbl.text = !mode ? "Light Mode" : "Dark Mode"
        knowMoreBtn.layer.borderColor = UIColor(named: "txt_green")?.cgColor
    }
    
    func openWebsite(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
