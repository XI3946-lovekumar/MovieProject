//
//  MoviesDetailScreen.swift
//  MovieProjectTests
//
//  Created by Apple on 12/01/23.
//

import XCTest
@testable import MovieProject

final class MoviesDetailScreen: XCTestCase, MoviesDetailViewModelMethods {
    
    private let movieViewModel = MoviesDetailViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieViewModel.movieId = 16
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMoviesDetailAPI() {
        let urlValue = URL.init(string: "http://api.themoviedb.org/3/movie/\(movieViewModel.movieId)")
        let expectation = self.expectation(description: "testMoviesDetailAPI")

        XCTAssertNotEqual(movieViewModel.movieId, 0)
        XCTAssertEqual(EndpointItem.moviesDetail(movieViewModel.movieId).url, urlValue)
        XCTAssertEqual(KeyConstant.Constant.apiKey.rawValue, Key.API.key.rawValue)
        XCTAssertEqual(KeyConstant.Constant.language.rawValue, Key.Constants.english.rawValue)
        
        self.moviesDetailAPI {
            XCTAssertNotNil(self.movieViewModel.moviesDetailModel)
            XCTAssertEqual(self.movieViewModel.moviesDetailModel?.genres?.isEmpty, false)
            XCTAssertEqual(self.movieViewModel.moviesDetailModel?.originalTitle?.isEmpty , false)
            XCTAssertEqual(self.movieViewModel.moviesDetailModel?.releaseDate?.isEmpty , false)
            XCTAssertEqual(self.movieViewModel.moviesDetailModel?.overview?.isEmpty , false)
            expectation.fulfill()
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func testInternetConnectionFailure() {
        let expectation = self.expectation(description: "testInternetConnectionFailure")
        self.moviesDetailAPI {
        } failure: { error in
            XCTAssertNotNil(error)
            XCTAssertEqual("No Internet Connection", error.debugDescription)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func moviesDetailAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->()) {
                
        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue] as [String : Any]
        
        if let data = self.jsonToData(fileName: KeyConstant.Constant.moviesDetail.rawValue) {
            MockServer.shared.dataValue = data
            
            MockServer.shared.call(type: EndpointItem.moviesDetail(self.movieViewModel.movieId), isLoaderActive: true, params: dict) { (resultValue: MoviesDetailModel?) in
                if let resultValue = resultValue {
                    self.movieViewModel.moviesDetailModel = resultValue
                    completion()
                }
            } failure: { result in
                failure(result)
            }
        }
    }
}
