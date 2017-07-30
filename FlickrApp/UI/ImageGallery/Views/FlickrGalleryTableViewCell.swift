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
        imgVwPhoto.af_setImage(withURL: URL(string: PhotoGalleryUtilities.getPhotoURL(flickrPhoto: photo))!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
