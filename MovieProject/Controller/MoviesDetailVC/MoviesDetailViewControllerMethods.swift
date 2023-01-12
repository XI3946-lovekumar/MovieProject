//
//  MoviesDetailViewControllerMethods.swift
//  MoviesProject
//
//  Created by Apple on 11/01/23.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegateFlowLayout
extension MoviesDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return headerSize
    }
}

//MARK: - UICollectionViewDataSource
extension MoviesDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesDetailModel?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Key.Cell_Id.moviesDetailCell.rawValue, for: indexPath) as! MoviesDetailCollectionViewCell
        cell.titleLabel.text = viewModel.moviesDetailModel?.genres?[indexPath.row].name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Key.Header_Id.moviesDetail.rawValue, for: indexPath) as! MoviesDetailHeaderView
        headerView.item = viewModel.moviesDetailModel
        calculateHeightofHeaderView(headerView: headerView)
        return headerView
    }
    
    func calculateHeightofHeaderView(headerView: MoviesDetailHeaderView) {
        let sideSpaces = (headerView.overviewLabel.frame.origin.x * 2)
        let overViewWidth = (collectionView.frame.size.width - sideSpaces)
        let overViewLabelHeight = viewModel.moviesDetailModel?.overview?.height(withConstrainedWidth: overViewWidth, font: headerView.overviewLabel.font) ?? 0
        let height = (headerView.overviewLabel.frame.maxX  + overViewLabelHeight) + 50
        self.headerSize = CGSize(width: collectionView.frame.width, height: height)
    }
}
