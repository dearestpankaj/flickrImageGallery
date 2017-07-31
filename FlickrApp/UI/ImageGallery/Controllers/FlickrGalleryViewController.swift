//
//  FlickrGalleryViewController.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit

let FlickrGalleryTableViewCellIdentifier = "FlickrGalleryTableViewCell"
let SegueShowPhotoViewController = "segueShowPhotoViewController"
let flickerUser = "41687112%40N06"

extension FlickrGalleryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: SegueShowPhotoViewController, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
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
        photos.fetchPhotoList(flickrUserID: flickerUser,successArrayResponse: {
            (arrResponse:[Photo]) -> Void in
            self.arrPhoto = arrResponse
        }, failure: {
            (data) -> Void in
            print(data)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == SegueShowPhotoViewController){
            if let indexPath = tblvwPics.indexPathForSelectedRow {
                if let destinationViewController = segue.destination as? ShowPhotoViewController{
                    destinationViewController.objPhoto = arrPhoto[indexPath.row]
                }
            }
        }
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
