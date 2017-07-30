//
//  FlickrGalleryTableViewCell.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/30/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import AlamofireImage

class FlickrGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVwPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    /// Set photo detail in tableview cell
    ///
    /// - Parameter photo: Photo object
    func loadData(photo:Photo){
        if let title = photo.title{
            lblTitle.text = title
        }
        imgVwPhoto.image = nil
        imgVwPhoto.af_setImage(withURL: URL(string: getPhotoURL(flickrPhoto: photo))!)
    }
    
    
    /// get url of the image from Photo Object
    ///
    /// - Parameter flickrPhoto: Photo object
    /// - Returns: image url
    func getPhotoURL(flickrPhoto:Photo)->String{
        var url = ""
        url = "https://farm" + String(flickrPhoto.farm!)
        url = url + ".staticflickr.com/"
        url = url + flickrPhoto.server!
        url = url + "/"+flickrPhoto.id!
        url = url + "_"+flickrPhoto.secret!+".jpg"
        return url
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
