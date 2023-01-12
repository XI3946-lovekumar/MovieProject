//
//  MoviesDetailViewModel.swift
//  MoviesProject
//
//  Created by Apple on 11/01/23.
//

import Foundation

protocol MoviesDetailViewModelMethods {
    func moviesDetailAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->())
}

final class MoviesDetailViewModel: MoviesDetailViewModelMethods {
    var movieId = 0
    var moviesDetailModel: MoviesDetailModel?
    
    // MARK: - moviesDetailAPI
    func moviesDetailAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->()) {
        
        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue] as [String : Any]
        
        APIManager.sharedInstance.call(type: EndpointItem.moviesDetail(movieId), isLoaderActive: true, params: dict) { (resultValue: MoviesDetailModel?) in
            if let resultValue = resultValue {
                self.moviesDetailModel = resultValue
                completion()
            }
        } failure: { result in
            failure(result)
        }
    }
}
