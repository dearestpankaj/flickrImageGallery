//
//  NetworkOperations.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import Alamofire

public enum NetworkError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
}

public enum HttpStatusCode : Int {
    case OK = 200                       // /GET, /DELETE result is successful
    case CREATED = 201                  // /POST or /PUT is successful
    case NOT_MODIFIED = 304             // If caching is enabled and etag matches with the server
    case BAD_REQUEST = 400              // Possibly the parameters are invalid
    case INVALID_CREDENTIAL = 401       // INVALID CREDENTIAL, possible invalid token
    case NOT_FOUND = 404                // The item you looked for is not found
    case CONFLICT = 409                 // Conflict - means already exist
    case AUTHENTICATION_EXPIRED = 419   // Expired
}

class NetworkOperations {
    
    
    /// Generic method to connect with REST services using Alamofire
    ///
    /// - Parameters:
    ///   - url: api url
    ///   - successArrayResponse: if response is as array
    ///   - successDictionaryResponse: if response is as dictionary
    ///   - failure: failure message
    func fetchResponse(url:String, successArrayResponse: ((_ arrContent:[AnyObject])->Void)?, successDictionaryResponse: ((_ dictContent:[String:AnyObject])->Void)?,failure: ((NetworkError)->Void)?) {
        
        Alamofire.request(url).responseJSON { response in
            if let statusCode = response.response?.statusCode{
                if(statusCode != HttpStatusCode.OK.rawValue && statusCode != HttpStatusCode.CREATED.rawValue) {
                    failure!(NetworkError.serverError)
                }
            }
            if (!response.result.isSuccess){
                failure!(NetworkError.connectionError)
            }
            if let JSON = response.result.value {
                if let array = JSON as? [AnyObject] {
                    successArrayResponse!(array)
                }else if let dict = JSON as? [String:AnyObject] {
                    print(dict)
                    successDictionaryResponse!(dict)
                }
            }else {
                failure!(NetworkError.notFound)
            }
        }
    }
}
