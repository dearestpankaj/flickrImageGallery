//
//  FlickrGalleryViewController.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit

let FlickrGalleryTableViewCellIdentifier = "FlickrGalleryTableViewCell"

extension FlickrGalleryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPhoto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlickrGalleryTableViewCellIdentifier, for: indexPath) as? FlickrGalleryTableViewCell
        cell?.loadData(photo: arrPhoto[indexPath.row])
        return cell!
    }
}

class FlickrGalleryViewController: UIViewController {
    @IBOutlet weak var tblvwPics: UITableView!
    
    var arrPhoto:[Photo] = [] {
        didSet{
            tblvwPics.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photos = PhotoLibraryService()
        photos.fetchPhotoList(successArrayResponse: {
            (arrResponse:[Photo]) -> Void in
            self.arrPhoto = arrResponse
        }, failure: {
            (data) -> Void in
            print(data)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
