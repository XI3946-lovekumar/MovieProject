//
//  Extensions.swift
//  MoviesProject
//
//  Created by Apple on 01/10/23.
//

import Foundation
import UIKit

// MARK: - UISearchBarMethods
extension UISearchBar {
    func getTextOnEdit(range: NSRange, string: String)-> String {
        let currentString: NSString = (self.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString as String
    }
}

// MARK: - UIViewControllerMethods
extension UIViewController {
    func setMaxLength( length: Int, completeString: String)-> Bool {
        let maxLength = length
        return completeString.count <= maxLength
    }
    
    func showAlert(_ alert: String, message: String) {
        let alert = UIAlertController.init(title: alert, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionViewMethods
extension UICollectionView {
    func registerCollectionViewClass(_ identifier: String) {
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - UITableViewMethods
extension UITableView {
    func registerTableViewClass(_ identifier: String) {
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderViewClass(_ identifier: String) {
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

// MARK: - UITableViewMethods
extension NSObject {
    var posterPlaceholder: UIImage! {
        return UIImage.init(named: Key.Constants.posterPlaceholder.rawValue)
    }
}

// MARK: - StringMethods
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
}

extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.adjustsFontForContentSizeCategory = true
    }
}
