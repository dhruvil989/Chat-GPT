//
//  LaunchVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import UIKit

class LaunchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDarkMode()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.moveToWelcomeVC()
        }
    }
    
    //MARK: - Methods
    func moveToWelcomeVC() {
        let welcomeVC = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    func setDarkMode() {
        let darkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = darkMode ? .dark : .light
        }
    }
}
