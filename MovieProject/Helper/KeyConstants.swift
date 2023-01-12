//
//  KeyConstants.swift
//  MoviesProject
//
//  Created by Apple on 01/10/23.
//

import Foundation

struct Key {
    
    // MARK: - API
    enum API: String {
        case key = "55957fcf3ba81b137f8fc01ac5a31fb5"
    }
    
    // MARK: - Cell_Id
    enum Cell_Id: String {
        case moviesDetailCell = "MoviesDetailCollectionViewCell"
        case mostPopularCell = "MostPopularTableViewCell"
        case tableCell = "TableViewCell"
        case playingCell = "PlayingCollectionViewCell"
    }
    
    // MARK: - Header_Id
    enum Header_Id: String {
        case moviesDetail = "MoviesDetailHeaderView"
        case moviesHeaderView = "MoviesHeaderView"
    }
    
    // MARK: - VC_Id
    enum VC_Id: String {
        case moviesDetail = "MoviesDetailViewController"
    }
    
    // MARK: - Constants
    enum Constants: String {
        case posterPlaceholder = "posterPlaceholder"
        case appName = "Movies"
        case posterBaseUrl = "http://image.tmdb.org/t/p/w92/"
        case english = "en-US"
        case notFound = "Couldn't find"
        case noInternet = "No Internet Connection"
        case playing = "Playing"
        case mostPopular = "Most Popular"
    }
}
