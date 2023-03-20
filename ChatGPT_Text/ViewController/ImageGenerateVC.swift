//
//  ImageGenerateVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 11/03/23.
//

import UIKit
import Lottie
import SDWebImage

class ImageGenerateVC: UIViewController {

    //MARK: - IBOulets
    @IBOutlet weak var generateBtn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var loaderVw: LottieAnimationView!
    @IBOutlet weak var mainLoaderVw: UIView!
    
    //MARK: - variable
    var arrImages: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialization()
    }
    
    //MARK: - IBActions
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func generateBtnClk(_ sender: UIButton) {
        if txtField.text! != "" {
            let text = txtField.text!
            self.txtField.text = ""
            self.mainLoaderVw.isHidden = false
            view.endEditing(true)
            generateImage(text: text, num: 10)
        } else {
            showAlert(message: "Type Something...")
        }
    }
    
    //MARK: - Methods
    func intialization() {
        loaderVw.loopMode = .loop
        loaderVw.animationSpeed = 2.0
        loaderVw.play()
        txtField.delegate = self
        generateBtn.setCornerRadius(radius: generateBtn.layer.bounds.height/2)
    }
    
    func generateImage(text: String, num: Int) {
        let viewModel = ViewModel()
        viewModel.generateImage(text: text, num: num) { data in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DALLEResponse.self, from: data)
                self.arrImages = response.data
                print(response)
                
                DispatchQueue.main.async {
                    self.mainLoaderVw.isHidden = true
                    self.moveToImagesVC()
                }
                
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.mainLoaderVw.isHidden = true
                    self.showAlert(message: error.localizedDescription)
                }
            }
        } failure: { error in
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.mainLoaderVw.isHidden = true
                self.showAlert(message: error.localizedDescription)
            }
        }

    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func moveToImagesVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImagesVC") as! ImagesVC
        vc.arrImages = self.arrImages
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ImageGenerateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
