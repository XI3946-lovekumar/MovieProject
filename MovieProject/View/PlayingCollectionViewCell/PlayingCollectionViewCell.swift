//
//  PlayingCollectionViewCell.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import UIKit
import SDWebImage

final class PlayingCollectionViewCell: UICollectionViewCell {
    /// IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    
    /// Varriables
    var item: NowPlayingResult! {
        didSet {
            let imagePath = "\(Key.Constants.posterBaseUrl.rawValue)\(item.posterPath ?? "")"
            let urlValue = URL.init(string: imagePath)
            imageView.sd_setImage(with: urlValue, placeholderImage: self.posterPlaceholder, context: nil)
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    var indexPath: IndexPath! {
        didSet {}
    }
}
