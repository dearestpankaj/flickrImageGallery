//
//  Photo.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import ObjectMapper

class Photo: Mappable {
    var id:String?
    var secret:String?
    var server:String?
    var farm:Int?
    var title:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
    }
}
