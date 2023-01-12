// 
//  URLHelper.swift
//  MoviesProject
//
//  Created by Apple on 01/10/23.
//

import Foundation
import Alamofire

protocol EndPointType {
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}

enum EndpointItem {
    // MARK: User actions
    case popular
    case nowPlaying
    case moviesDetail(Int)
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        return "http://api.themoviedb.org/3/movie/"
    }
    
    // MARK: - Vars & Lets
    var path: String {
        switch self {
        case .moviesDetail(let type):
            return "\(type)"
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return [ "Content-Type": "application/json"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: (self.baseURL + self.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
}

