//
//  PhotoGalleryUtilities.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/31/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit

class PhotoGalleryUtilities: NSObject {
    
    /// get url of the image from Photo Object
    ///
    /// - Parameter flickrPhoto: Photo object
    /// - Returns: image url
    class func getPhotoURL(flickrPhoto:Photo)->String{
        var url = ""
        url = "https://farm" + String(flickrPhoto.farm!)
        url = url + ".staticflickr.com/"
        url = url + flickrPhoto.server!
        url = url + "/"+flickrPhoto.id!
        url = url + "_"+flickrPhoto.secret!+".jpg"
        return url
    }
}
