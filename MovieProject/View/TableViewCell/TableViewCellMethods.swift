//
//  TableViewCellMethods.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource
extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayNowPlaying.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return playingCollectionViewCell(indexPath)
    }
    
    private func playingCollectionViewCell(_ indexPath: IndexPath)-> PlayingCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Key.Cell_Id.playingCell.rawValue, for: indexPath) as! PlayingCollectionViewCell
        cell.item = arrayNowPlaying[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegates?.collectionView(willDisplayForItemAt: indexPath, tableCellIndexValue: self.tableIndexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size
        let cellWidth = (collectionViewSize.width) / 4.2
        let cellHeight = collectionViewSize.height
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
}
