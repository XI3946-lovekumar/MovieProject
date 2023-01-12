//
//  MoviesDetailCollectionViewCell.swift
//  MoviesProject
//
//  Created by Apple on 11/01/23.
//

import UIKit

final class MoviesDetailCollectionViewCell: UICollectionViewCell {
    ///IBOutlet
    @IBOutlet weak var contentLabelView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    private func setUpUI() {
        contentLabelView.layer.cornerRadius = 5
        contentLabelView.clipsToBounds = true
    }
}
