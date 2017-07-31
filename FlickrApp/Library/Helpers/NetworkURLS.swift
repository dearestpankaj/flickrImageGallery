//
//  NetworkURLS.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import Foundation

let apiKey = "f0d8241da4cb824c2e1cf983b0738f5e"
let baseURL = "https://api.flickr.com/services/rest/"

class NetworkURLS : NSObject {
    class func publicPhoto(userid:String)->String {
        let publicPhotoURL = baseURL + "?method=flickr.people.getPublicPhotos&api_key="+apiKey+"&user_id="+userid+"&format=json&nojsoncallback=1"
        return publicPhotoURL
    }
}
