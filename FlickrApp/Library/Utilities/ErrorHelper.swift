//
//  ErrorHelper.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/31/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import Foundation

class ErrorHelper {
    
    static let errorDomain = "com.tigerspike.FlickrApp"
    
    static func error(_ message: String, record: Bool = true, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        
        let customError = NSError(domain: errorDomain, code: 0, userInfo: [
            NSLocalizedDescriptionKey: message])
        
        return customError
    }
}
