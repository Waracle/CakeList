//
//  NetworkService.swift
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation
import UIKit

class NetworkService: NSObject {
    
    // MARK: Properties
    
    typealias FetchRequestCompletion<T> = (T?, Error?) -> Swift.Void
    typealias FetchCakesCompletion = FetchRequestCompletion<[Cake]>
    typealias FetchCakeImageCompletion = FetchRequestCompletion<UIImage>
    
    
    fileprivate let session = URLSession.shared
    
    // MARK: Instantiation
    
    static let shared = NetworkService()
    
    // MARK: Requests
    
    func fetchAllCakes(with completion: @escaping FetchCakesCompletion) {
        
        guard let cakesURL = Constants.CakesURL else {
            
            return completion(nil, nil)
        }
        
        fetchData(for: cakesURL, completion: completion)
    }
    
    func fetchImage(for cake: Cake, completion: @escaping FetchCakeImageCompletion) {
        
        guard let imageURLString = cake.imageURLString, let imageURL = URL(string: imageURLString) else {
            
            return completion(nil, nil)
        }
        
        fetchData(for: imageURL, completion: completion)
    }
}

// MARK: Request implementation

extension NetworkService {
    
    func fetchData<T>(for url: URL, completion: @escaping FetchRequestCompletion<T>) {
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                
                return self.requestCompleted(with: nil, error: error, completion: completion)
            }
            
            if let response = response {
                
                if response.isSuccessfulRequest() {
                    
                    return self.parseResponse(for: data, completion: completion)
                }
                
                return self.requestCompleted(with: nil, error: NetworkServiceError.networkRequestFailed, completion: completion)
            }
            
            self.requestCompleted(with: nil, error: NetworkServiceError.unknownError, completion: completion)
      
        }.resume()
    }
    
    func parseResponse<T>(for data: Data?, completion: @escaping FetchRequestCompletion<T>) {
        
        guard let data = data else {
            
            return requestCompleted(with: nil, error: NetworkServiceError.responseDataNil, completion: completion)
        }
        
        if completion is FetchCakesCompletion {
            
            do {
                
                var allCakes: [Cake] = []
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:AnyObject]]
                
                for cakeDictionary in jsonObject! {
                    
                    let cake = Cake(dictionary: cakeDictionary)
                    allCakes.append(cake!)
                }
                
                return requestCompleted(with: allCakes as? T, error: nil, completion: completion)
                
            } catch let serializationError {
                
                return requestCompleted(with: nil, error: serializationError, completion: completion)
            }
        
        } else if completion is FetchCakeImageCompletion {
            
            let cakeImage = UIImage(data: data)
            return requestCompleted(with: cakeImage as? T, error: nil, completion: completion)
        }
    }
    
    func requestCompleted<T>(with object: T?, error: Error?, completion: @escaping FetchRequestCompletion<T>) {
        
        DispatchQueue.main.async {
            
            completion(object, error)
        }
    }
}
