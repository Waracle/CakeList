//
//  URLResponse+Extension.swift
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation

extension URLResponse {
    
    func isSuccessfulRequest() -> Bool {
        
        if let httpURLResponse = self as? HTTPURLResponse {
            
            return httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 400
        }
        
        return false
    }
}

