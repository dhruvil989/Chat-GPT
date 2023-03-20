//
//  Extensions.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 20/03/23.
//

import UIKit

//MARK: - UIView
extension UIView {
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func setBorder(borderWidth: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
    }
}

//MARK: - UITableView
extension UITableView {
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

