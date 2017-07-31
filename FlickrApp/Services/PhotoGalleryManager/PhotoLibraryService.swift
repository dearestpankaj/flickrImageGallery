//
//  PhotoLibraryService.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import ObjectMapper

class PhotoLibraryService: NSObject {
    
    /// Fetch list of photos from flickr api
    ///
    /// - Parameters:
    ///   - successArrayResponse: array of Photo objects
    ///   - failure: failure error
    func fetchPhotoList(flickrUserID:String, successArrayResponse: @escaping ((_ arrContent:[Photo])->Void),failure: @escaping ((NetworkError)->Void)) {
        let network = NetworkOperations()
        network.fetchResponse(url: NetworkURLS.publicPhoto(userid: flickrUserID), successArrayResponse: {
            (response:[AnyObject]) -> Void in
            successArrayResponse(self.createPhotoModel(array: response))
        }, successDictionaryResponse: {
            (response:[String:AnyObject]) -> Void in
            if let photos = response["photos"]{
                if let photo = photos["photo"] as? [AnyObject]{
                    successArrayResponse(self.createPhotoModel(array: photo))
                }
            }
        }, failure: {
            (data) -> Void in
            failure(data)
        })
    }
    
    
    /// Convert json object to Photo object
    ///
    /// - Parameter array: array of json objects
    /// - Returns: array of Photo object
    private func createPhotoModel(array:[AnyObject]) -> [Photo]{
        var arrPhoto = [Photo]()
        for item in array {
            if let objPhoto = Mapper<Photo>().map(JSONObject:item){
                arrPhoto.append(objPhoto)
            }
        }
        return arrPhoto
    }
    
}
