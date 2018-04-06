//
//  NSError+Extension.swift
//  Cake List
//
//  Created by Harmeet Singh on 05/04/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    
    case unknownError
    case networkRequestFailed
    case responseDataNil
}

