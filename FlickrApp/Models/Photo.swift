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
    
    init(id: String, secret: String, server: String, farm:Int, title:String) {
        self.id = id
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
    }
    
    required init?(map: Map){
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        secret <- map["secret"]
        server <- map["server"]
        farm <- map["farm"]
        title <- map["title"]
    }
    
    func getPhotoURL()->String{
        var url = ""
        url = "https://farm" + String(self.farm!)
        url = url + ".staticflickr.com/"
        url = url + self.server!
        url = url + "/"+self.id!
        url = url + "_"+self.secret!+".jpg"
        return url
    }
}
