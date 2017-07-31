//
//  UIAlertController+FlickerApp.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 8/1/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func presentCustomAlertControllerWithTitle(_ title : String, message : String, Button arrayTitle : [String],From controller: UIViewController, WithAction callback: @escaping (Int) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        var counter = 0
        for btntitle in arrayTitle{
            alert.addAction(UIAlertAction(title: btntitle, style: UIAlertActionStyle.default, handler: {action in
                callback(counter)
                counter = counter + 1
            }))
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
}
