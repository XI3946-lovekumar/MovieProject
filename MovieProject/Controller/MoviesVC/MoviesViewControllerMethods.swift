//
//  MoviesViewControllerMethods.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import Foundation
import UIKit

// MARK: - UICollectionViewDataSource
extension MoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == MoviesViewModel.TableViewSection.nowPlaying.rawValue) ? 1 : viewModel.arrayPopular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            return tableViewCell(indexPath)
        } else {
            return mostPopularTableViewCell(indexPath)
        }
    }
    
    private func tableViewCell(_ indexPath: IndexPath)-> TableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Key.Cell_Id.tableCell.rawValue) as! TableViewCell
        cell.tableIndexPath = indexPath
        cell.delegates = self
        cell.arrayNowPlaying = viewModel.arrayNowPlaying
        return cell
    }
    
    private func mostPopularTableViewCell(_ indexPath: IndexPath)-> MostPopularTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Key.Cell_Id.mostPopularCell.rawValue) as! MostPopularTableViewCell
        cell.item = viewModel.arrayPopular[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isPopularCallEnable(indexPath) {
            self.getPopularData()
        }
    }
}

// MARK: - TableViewCellDelegate
extension MoviesViewController: TableViewCellDelegate {
    func collectionView(willDisplayForItemAt indexPath: IndexPath, tableCellIndexValue: IndexPath) {
        if viewModel.isNowPlayingCallEnable(indexPath.row) {
            self.getNowPlayingAPI()
        }
    }
    
    func collectionView(didSelectItemAt indexPath: IndexPath, tableCellIndexValue: IndexPath) {
        let movieId = self.viewModel.arrayNowPlaying[indexPath.row].id ?? 0
        presentMoviesDetail(movieId)
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == MoviesViewModel.TableViewSection.popular.rawValue {
            let movieId = self.viewModel.arrayPopular[indexPath.row].id ?? 0
            presentMoviesDetail(movieId)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == MoviesViewModel.TableViewSection.nowPlaying.rawValue {
            return MoviesViewModel.TableViewHeights.nowPlaying.rawValue
        } else {
            return MoviesViewModel.TableViewHeights.popular.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MoviesViewModel.TableViewHeights.headerHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Key.Header_Id.moviesHeaderView.rawValue) as! MoviesHeaderView
        guard section == MoviesViewModel.TableViewSection.nowPlaying.rawValue else {
            if viewModel.arrayPopular.isEmpty {
                return nil
            } else {
                headerView.headerTitleLabel.text = MoviesViewModel.HeaderTitle.popular.rawValue
                return headerView
            }
        }
        
        if viewModel.arrayNowPlaying.isEmpty {
            return nil
        } else {
            headerView.headerTitleLabel.text = MoviesViewModel.HeaderTitle.nowPlaying.rawValue
            return headerView
        }
    }
}
