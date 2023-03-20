//
//  ImageCollectionCell.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 11/03/23.
//

import UIKit
import Lottie

class ImageCollectionCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var loaderVw: LottieAnimationView!
    
    //MARK: - variables
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loaderVw.loopMode = .loop
        loaderVw.animationSpeed = 2.0
        loaderVw.play()
        
        imgVw.setCornerRadius(radius: 10)
        downloadBtn.setCornerRadius(radius: downloadBtn.layer.bounds.width/2)
        mainVw.setCornerRadius(radius: 10)
        mainVw.setBorder(borderWidth: 1, color: UIColor(named: "seperator_gray")!)
    }

    //MARK: - IBAction
    @IBAction func downloadBtn(_ sender: Any) {
        saveImage()
    }
    
    func saveImage() {
        let inputImage = imgVw.image ?? UIImage()
        UIImageWriteToSavedPhotosAlbum(inputImage, self, #selector(saveCompleted(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            downloadBtn.isUserInteractionEnabled = false
            downloadBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
}
