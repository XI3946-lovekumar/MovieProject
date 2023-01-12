//
//  MoviesViewModel.swift
//  MoviesProject
//
//  Created by Apple on 10/01/23.
//

import Foundation
import UIKit

protocol MoviesViewModelMethods {
    func popularAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->())
    func nowPlayingAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->())
}

final class MoviesViewModel: MoviesViewModelMethods {
    
    enum TableViewHeights: CGFloat {
        case nowPlaying = 160
        case popular = 127
        case headerHeight = 50
    }
    
    enum TableViewSection: Int {
        case nowPlaying = 0
        case popular = 1
    }
    
    enum HeaderTitle: String {
        case nowPlaying = "Playing Now"
        case popular = "Most Popular"
    }
    
    var popularCallData = APICallData()
    var nowPlayingCallData = APICallData()
    var arrayPopular = [PopularModelResult]()
    var arrayNowPlaying = [NowPlayingResult]()
    
 
    // MARK: - PopularAPI
    func popularAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->()) {
        popularCallData.isFetching = true
        
        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue,
                    "page" : popularCallData.pageNo] as [String : Any]
        
        APIManager.sharedInstance.call(type: EndpointItem.popular, isLoaderActive: self.arrayPopular.isEmpty, params: dict) { (resultValue: PopularModel?) in
            self.popularCallData.isFetching = false
            
            if let resultValue = resultValue {
                self.popularCallData.totalPageNo = resultValue.totalPages ?? 0

                if self.popularCallData.pageNo == 1 {
                    self.arrayPopular.removeAll()
                }
                self.arrayPopular.append(contentsOf: resultValue.results ?? [])
                completion()
            }
            
        } failure: { result in
            self.popularCallData.isFetching = false
            failure(result)
        }
    }
    
    // MARK: - NowPlayingAPI
    func nowPlayingAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->()) {
        self.nowPlayingCallData.isFetching = true

        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue,
                    "page" : self.nowPlayingCallData.pageNo] as [String : Any]
        
        APIManager.sharedInstance.call(type: EndpointItem.nowPlaying, isLoaderActive: self.arrayNowPlaying.isEmpty, params: dict) { (resultValue: NowPlayingModel?) in
            self.nowPlayingCallData.isFetching = false
            if let resultValue = resultValue {
                self.nowPlayingCallData.totalPageNo = resultValue.totalPages ?? 0

                if self.nowPlayingCallData.pageNo == 1 {
                    self.arrayNowPlaying.removeAll()
                }
                self.arrayNowPlaying.append(contentsOf: resultValue.results ?? [])
                completion()
            }
            
        } failure: { result in
            self.nowPlayingCallData.isFetching = false
            failure(result)
        }
    }
    
    func restartAPI() {
        self.nowPlayingCallData.pageNo = 1
        self.popularCallData.pageNo = 1
    }
    
    func isPopularCallEnable(_ indexPath: IndexPath)-> Bool {
        guard indexPath.section == MoviesViewModel.TableViewSection.popular.rawValue else {
            return false
        }
        
        if indexPath.row == (self.arrayPopular.count - 2) && popularCallData.pageNo < (popularCallData.totalPageNo) && !popularCallData.isFetching {
            popularCallData.pageNo = (popularCallData.pageNo + 1)
            return true
        }
        return false
    }
    
    func isNowPlayingCallEnable(_ indexValue: Int)-> Bool {
        if indexValue == (self.arrayNowPlaying.count - 2) && nowPlayingCallData.pageNo < (nowPlayingCallData.totalPageNo) && !nowPlayingCallData.isFetching {
            nowPlayingCallData.pageNo = (nowPlayingCallData.pageNo + 1)
            return true
        }
        return false
    }
}
