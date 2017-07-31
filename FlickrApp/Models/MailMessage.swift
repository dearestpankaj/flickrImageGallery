//
//  MailMessage.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/31/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import Foundation
import UIKit

class MailMessage: NSObject {
    var toRecipients:[String]?
    var subject:String?
    var messageBody:String?
    var imageAttachment: UIImage
    
    required init?(toRecipients:[String], subject:String, messageBody:String, imageAttachment: UIImage){
        self.toRecipients = toRecipients
        self.subject = subject
        self.messageBody = messageBody
        self.imageAttachment = imageAttachment
    }
    
}
