//
//  ImagesVC.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 12/03/23.
//

import UIKit
import SDWebImage
import Photos

class ImagesVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var imgClcVw: UICollectionView!
    
    //MARK: - variable
    var arrImages: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgClcVw.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
    }
    
    //MARK: - IBAction
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }
    
}

extension ImagesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imgClcVw.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        
        cell.downloadBtn.isHidden = true
        cell.loaderVw.isHidden = false
        
        cell.imgVw.sd_setImage(with: URL(string: arrImages[indexPath.row].url), placeholderImage: UIImage()) { image, error, type, url in
            cell.downloadBtn.isHidden = false
            cell.loaderVw.isHidden = true
        }
        
        return cell
    }
}

extension ImagesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width-60)/2
        return CGSize(width: size, height: size)
    }
}
