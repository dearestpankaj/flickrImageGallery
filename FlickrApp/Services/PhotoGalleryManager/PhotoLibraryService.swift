//
//  PhotoLibraryService.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit

class PhotoLibraryService: NSObject {
    
    func fetchPhotoList(successArrayResponse: @escaping ((_ arrContent:[Photo])->Void),failure: @escaping ((NetworkError)->Void)) {
        let network = NetworkOperations()
        network.fetchResponse(url: NetworkURLS.publicPhotoURL, successArrayResponse: {
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
            print(data)
            failure(data)
        })
    }
    
    private func createPhotoModel(array:[AnyObject]) -> [Photo]{
        var arrPhoto = [Photo]()
        for item in array {
            let objPhoto = Photo()
            if let id = item["id"] as? String {
                objPhoto.id = id
            }
            if let secret = item["secret"] as? String {
                objPhoto.secret = secret
            }
            if let server = item["server"] as? String {
                objPhoto.server = server
            }
            if let farm = item["farm"] as? Int {
                objPhoto.farm = farm
            }
            if let title = item["title"] as? String {
                objPhoto.title = title
            }
            arrPhoto.append(objPhoto)
        }
        return arrPhoto
    }
    
}
