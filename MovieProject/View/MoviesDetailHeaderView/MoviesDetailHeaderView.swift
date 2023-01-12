//
//  MoviesDetailHeaderView.swift
//  MoviesProject
//
//  Created by Apple on 11/01/23.
//

import UIKit
import SDWebImage

class MoviesDetailHeaderView: UICollectionReusableView {
    ///
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: MoviesDetailModel? {
        didSet {
            titleLabel.text = item?.originalTitle
            dateLabel.text = item?.releaseDate
            overviewLabel.text = item?.overview
            
            let imagePath = "\(Key.Constants.posterBaseUrl.rawValue)\(item?.posterPath ?? "")"
            let urlValue = URL.init(string: imagePath)
            itemImageView.sd_setImage(with: urlValue, placeholderImage: self.posterPlaceholder, context: nil)
        }
    }
}
