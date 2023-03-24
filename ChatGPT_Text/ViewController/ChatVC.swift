//
//  ChatVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import UIKit
import Lottie
import SideMenu

class ChatVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var chatTblVw: UITableView!
    @IBOutlet weak var chatTxtField: UITextField!
    @IBOutlet weak var nslc_txtFieldVwBottom: NSLayoutConstraint!
    @IBOutlet weak var loaderView: LottieAnimationView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var mainExmVw: UIView!
    @IBOutlet weak var exmVw1: UIView!
    @IBOutlet weak var exmVw2: UIView!
    @IBOutlet weak var exmVw3: UIView!
    @IBOutlet weak var quesLabel1: UILabel!
    @IBOutlet weak var quesLabel2: UILabel!
    @IBOutlet weak var quesLabel3: UILabel!
    
    //MARK: - Variable
    var arrChats: [OpenAPIResponse] = []
    var arrQuestion = ["What is swift programming language?", "Creative ideas for a 10 year old's birthday?", "How do I make an HTTP request in Javascript?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 2.0
        loaderView.play()
        self.chatTblVw.reloadData()
    }

    //MARK: - IBActions
    @IBAction func menuBtnClk(_ sender: UIButton) {
        openSideMenu()
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        if chatTxtField.text != "" {
            let text = chatTxtField.text ?? ""
            DispatchQueue.main.async {
                self.handleFetch(text: text)
            }
        } else {
            self.showAlert(message: "Type Something...")
        }
    }
    
    @IBAction func exampleBtnClk(_ sender: UIButton) {
        var text = ""
        
        switch sender.tag {
        case 1: text = arrQuestion[0]
        case 2: text = arrQuestion[1]
        case 3: text = arrQuestion[2]
        default:
            print("default")
        }
        
        self.handleFetch(text: text)
        
    }
    
    @IBAction func moreBtnClk(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageGenerateVC") as! ImageGenerateVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Methods
    func initialSetup() {
        chatTblVw.register(UINib(nibName: "ChatTblVwCell", bundle: nil), forCellReuseIdentifier: "ChatTblVwCell")
        chatTblVw.register(UINib(nibName: "UserTblVwCell", bundle: nil), forCellReuseIdentifier: "UserTblVwCell")
        
        loaderView.loopMode = .loop
        loaderView.animationSpeed = 2.0
        loaderView.play()
        
        quesLabel1.text = arrQuestion[0]
        quesLabel2.text = arrQuestion[1]
        quesLabel3.text = arrQuestion[2]
        
        self.mainExmVw.setCornerRadius(radius: 5)
        self.exmVw1.setCornerRadius(radius: 5)
        self.exmVw2.setCornerRadius(radius: 5)
        self.exmVw3.setCornerRadius(radius: 5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(clearConversation),name:NSNotification.Name("clearConversation"), object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(backToHome),name:NSNotification.Name("back"), object: nil)
    }
    
    func openSideMenu() {
        let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
        
        menu.presentationStyle = .menuSlideIn
        menu.presentationStyle.backgroundColor = .green
        menu.presentationStyle.onTopShadowOffset = .zero
        menu.presentationStyle.onTopShadowColor = .black
        menu.presentationStyle.onTopShadowRadius = 50
        menu.presentationStyle.onTopShadowOpacity = 0.1
        present(menu, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func handleError(error: String) {
        print(error)
        let gptChat: OpenAPIResponse = OpenAPIResponse(id: "2", object: "Gpt message", created: 1, choices: [Choice(index: 1, message: Message(role: "Error", content: "Error: \(error)"), finishReason: "question")], usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        if !self.arrChats.isEmpty {
            self.arrChats.removeLast()
        }
        self.arrChats.append(gptChat)
        self.btnView.isHidden = false
        self.chatTblVw.reloadData()
        self.chatTblVw.scrollToBottom()
    }
    
    func fetchResult(text : String) {
        let viewModel = ViewModel()
        viewModel.send(text: text) { data in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(OpenAPIResponse.self, from: data)
                if !self.arrChats.isEmpty {
                    self.arrChats.removeLast()
                }
                
                self.arrChats.append(response)
                print(response.choices[0].message)
                
                DispatchQueue.main.async {
                    self.chatTblVw.reloadData()
                    self.chatTblVw.scrollToBottom()
                    self.btnView.isHidden = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.handleError(error: error.localizedDescription)
                }
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.handleError(error: error.localizedDescription)
            }
        }
    }
    
    @objc func handleFetch(text: String) {
        let userChat = OpenAPIResponse(id: "1", object: "My message", created: 1, choices: [Choice(index: 1, message: Message(role: "User", content: text), finishReason: "question")], usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        let gptChat = OpenAPIResponse(id: "2", object: "Gpt message", created: 1, choices: [Choice(index: 1, message: Message(role: "Animation", content: "12345"), finishReason: "question")], usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0))
        
        btnView.isHidden = true
        view.endEditing(true)
        arrChats.append(contentsOf: [userChat, gptChat])
        self.chatTblVw.reloadData()
        self.chatTblVw.scrollToBottom()
        self.chatTxtField.text = ""
        self.fetchResult(text: text)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height
            nslc_txtFieldVwBottom.constant = adjustmentHeight
        }
        else {
            nslc_txtFieldVwBottom.constant = 0
        }
        print("\(keyboardFrame)")
    }
}

//MARK: - HandleOptions
extension ChatVC {
    @objc func clearConversation() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(handleFetch(text:)), object: nil)
        self.btnView.isHidden = false
        self.arrChats.removeAll()
        self.chatTblVw.reloadData()
    }
    
    @objc func backToHome() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.isHidden = arrChats.count == 0
        mainExmVw.isHidden = !tableView.isHidden
        return arrChats.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrChats[indexPath.section].choices[0].message.role == "User" {
            let cell = chatTblVw.dequeueReusableCell(withIdentifier: "UserTblVwCell", for: indexPath) as! UserTblVwCell
            
            let message = arrChats[indexPath.section].choices[0].message.content
            cell.userChatLbl?.text = message
            return cell
        } else {
            let cell = chatTblVw.dequeueReusableCell(withIdentifier: "ChatTblVwCell", for: indexPath) as! ChatTblVwCell
            cell.initialSetup()
            
            var message = arrChats[indexPath.section].choices[0].message.content
            if message.contains("\n") {
                message.removeFirst()
                message.removeFirst()
            }
            
            cell.chatLbl.text = message
            cell.chatLbl.isHidden = arrChats[indexPath.section].choices[0].message.role == "Animation"
            cell.animationVw.isHidden = arrChats[indexPath.section].choices[0].message.role != "Animation"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension ChatVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //self.chatTblVw.scrollToBottom()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
