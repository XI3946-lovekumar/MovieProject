//
//  TableViewCell.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import UIKit

protocol TableViewCellDelegate {
    func collectionView(willDisplayForItemAt indexPath: IndexPath, tableCellIndexValue: IndexPath)
}

class TableViewCell: UITableViewCell {
    ///IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// Varriables
    var delegates: TableViewCellDelegate?
    var arrayNowPlaying: [NowPlayingResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tableIndexPath: IndexPath! {
        didSet {
            collectionView.tag = tableIndexPath.row
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCollectionViewClass(Key.Cell_Id.playingCell.rawValue)
    }
}
