//
//  APIManager.swift
//  MoviesProject
//
//  Created by Apple on 01/10/23.
//

import Foundation
import Alamofire
import UIKit

protocol HTTPClientProtocol {
    func cancelAFRequest(_ endPoint: EndPointType)
    func call<T: Codable>(type: EndPointType, isLoaderActive: Bool, params: Parameters?, completion:@escaping (_ result : T?) -> Void, failure: @escaping (_ result : Any?) -> Void)
}

final class APIManager: HTTPClientProtocol {
    /// SharedInstance
    static let sharedInstance = APIManager()
    
    private init() {
        self.setupActivityIndicator()
    }
    
    /// Varriables
    let activityLoader = UIActivityIndicatorView()
    
    func cancelAFRequest(_ endPoint: EndPointType) {
        AF.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            for item in dataTasks {
                if let urlValue = item.currentRequest?.url?.absoluteString {
                    if urlValue.contains(endPoint.url.absoluteString) {
                        item.cancel()
                    }
                }
            }
        }
    }
    
    func call<T: Codable>(type: EndPointType, isLoaderActive: Bool, params: Parameters?, completion: @escaping (_ result : T?) -> Void, failure: @escaping (_ result : Any?) -> Void) {
        
        guard Reachability.isConnectedToNetwork() else {
            failure(Key.Constants.noInternet.rawValue)
            return
        }
        
        if isLoaderActive {
            self.showLoader()
        }
        
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: params,
                   encoding: type.encoding,
                   headers: type.headers).validate().responseJSON { data in
            
            switch data.result {
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = data.data {
                    let result = try? decoder.decode(T.self, from: jsonData)
                    if isLoaderActive {
                        self.hideLoader()
                    }
                    completion(result)
                }
                break
            case .failure(let error):
                if isLoaderActive {
                    self.hideLoader()
                }
                failure(error.localizedDescription)
                break
            }
        }
    }
    
    func setupActivityIndicator() {
        guard let topWindow = UIApplication.shared.windows.last else {return}
        let viewFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let overlayView = UIView(frame: viewFrame)
        overlayView.backgroundColor = .clear
        topWindow.addSubview(overlayView)
        activityLoader.frame = overlayView.bounds
        overlayView.addSubview(activityLoader)
        overlayView.center = topWindow.center
        activityLoader.style = .large
        activityLoader.color = .gray
        activityLoader.isHidden = false
        activityLoader.hidesWhenStopped = true
    }
    
    func showLoader() {
        activityLoader.startAnimating()
    }
    
    func hideLoader() {
        activityLoader.stopAnimating()
    }
}
