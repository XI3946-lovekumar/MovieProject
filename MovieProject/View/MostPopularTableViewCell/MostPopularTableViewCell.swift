//
//  MostPopularTableViewCell.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import UIKit
import SDWebImage

class MostPopularTableViewCell: UITableViewCell {
    ///IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var progressView: CircularProgressView!
    
    var indexPath: IndexPath! {
        didSet {}
    }
    
    var item: PopularModelResult! {
        didSet {
            dateLabel.text = item.releaseDate ?? ""
            titleLabel.text = item.originalTitle ?? ""
            
            let imagePath = "\(Key.Constants.posterBaseUrl.rawValue)\(item.posterPath ?? "")"
            let urlValue = URL.init(string: imagePath)
            itemImageView.sd_setImage(with: urlValue, placeholderImage: self.posterPlaceholder, context: nil)
            
            let voteAvrage = item?.voteAverage ?? 0.00
            let value = Float(voteAvrage / 10.0)
            progressView.setProgressWithAnimation(duration: 0.4, value: value)
        }
    }
}
