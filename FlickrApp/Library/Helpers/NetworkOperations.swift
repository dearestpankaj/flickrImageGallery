//
//  NetworkOperations.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import Alamofire

enum NetworkError: Error {
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

class NetworkOperations {
    
    func fetchResponse(url:String, successArrayResponse: ((_ arrContent:[AnyObject])->Void)?, successDictionaryResponse: ((_ dictContent:[String:AnyObject])->Void)?,failure: ((NetworkError)->Void)?){
        
        Alamofire.request(url).responseJSON { response in
            if let statusCode = response.response?.statusCode{
                if(statusCode != 200 && statusCode != 201){
                    failure!(NetworkError.serverError)
                }
            }
            if (!response.result.isSuccess){
                failure!(NetworkError.connectionError)
            }
            if let JSON = response.result.value {
                if let array = JSON as? [AnyObject]{
                    successArrayResponse!(array)
                }
                else if let dict = JSON as? [String:AnyObject]{
                    print(dict)
                    successDictionaryResponse!(dict)
                }
            }
            else{
                failure!(NetworkError.notFound)
            }
            
        }

    }
}
