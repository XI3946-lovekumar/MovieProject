//
//  MovieProjectTests.swift
//  MovieProjectTests
//
//  Created by Apple on 11/01/23.
//

import XCTest
@testable import MovieProject

final class MovieProjectTests: XCTestCase, MoviesViewModelMethods {
    
    private let movieViewModel = MoviesViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNowPlayingAPI() {
        let urlValue = URL.init(string: "http://api.themoviedb.org/3/movie/now_playing")
        let expectation = self.expectation(description: "nowPlayingAPI")

        XCTAssertEqual(EndpointItem.nowPlaying.url, urlValue)
        XCTAssertEqual(KeyConstant.Constant.apiKey.rawValue, Key.API.key.rawValue)
        XCTAssertEqual(KeyConstant.Constant.language.rawValue, Key.Constants.english.rawValue)
        
        self.nowPlayingAPI {
            XCTAssertEqual(self.movieViewModel.arrayNowPlaying.isEmpty, false)
            expectation.fulfill()
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPopularAPI() {
        let expectation = self.expectation(description: "popularAPI")
        let urlValue = URL.init(string: "http://api.themoviedb.org/3/movie/popular")
        
        XCTAssertEqual(EndpointItem.popular.url, urlValue)
        XCTAssertEqual(KeyConstant.Constant.apiKey.rawValue, Key.API.key.rawValue)
        XCTAssertEqual(KeyConstant.Constant.language.rawValue, Key.Constants.english.rawValue)
        
        self.popularAPI {
            XCTAssertEqual(self.movieViewModel.arrayPopular.isEmpty, false )
            expectation.fulfill()
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func testInternetConnectionFailure() {
        let expectation = self.expectation(description: "testInternetConnectionFailure")
        self.popularAPI {
        } failure: { error in
            XCTAssertNotNil(error)
            XCTAssertEqual("No Internet Connection", error.debugDescription)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func popularAPI(completion: @escaping () -> (), failure: @escaping (Any?) -> ()) {
        movieViewModel.popularCallData.isFetching = true
                
        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue,
                    "page" : movieViewModel.popularCallData.pageNo] as [String : Any]
        
        if let data = self.jsonToData(fileName: KeyConstant.Constant.popular.rawValue) {
            MockServer.shared.dataValue = data
            
            MockServer.shared.call(type: EndpointItem.popular, isLoaderActive: true, params: dict) { (resultValue: PopularModel?) in
                if let resultValue = resultValue {
                    self.movieViewModel.popularCallData.totalPageNo = resultValue.totalPages ?? 0
                    
                    if self.movieViewModel.popularCallData.pageNo == 1 {
                        self.movieViewModel.arrayPopular.removeAll()
                    }
                    self.movieViewModel.arrayPopular.append(contentsOf: resultValue.results ?? [])
                }
                completion()
            } failure: { result in
                failure(result)
            }
        }
    }
    
    func nowPlayingAPI(completion: @escaping ()->(), failure: @escaping (_ error: Any?)->()) {
        movieViewModel.nowPlayingCallData.isFetching = true
                
        let dict = ["api_key": Key.API.key.rawValue,
                    "language": Key.Constants.english.rawValue,
                    "page" : movieViewModel.popularCallData.pageNo] as [String : Any]
        
        if let data = self.jsonToData(fileName: KeyConstant.Constant.noPlaying.rawValue) {
            MockServer.shared.dataValue = data
            
            MockServer.shared.call(type: EndpointItem.popular, isLoaderActive: true, params: dict) { (resultValue: NowPlayingModel?) in
                if let resultValue = resultValue {
                    self.movieViewModel.nowPlayingCallData.totalPageNo = resultValue.totalPages ?? 0
                    
                    if self.movieViewModel.nowPlayingCallData.pageNo == 1 {
                        self.movieViewModel.arrayNowPlaying.removeAll()
                    }
                    self.movieViewModel.arrayNowPlaying.append(contentsOf: resultValue.results ?? [])
                }
                completion()
            } failure: { result in
                failure(result)
            }
        }
    }
}

