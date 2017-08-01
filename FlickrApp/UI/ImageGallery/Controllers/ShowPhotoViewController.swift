//
//  ShowPhotoViewController.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/30/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import AlamofireImage


extension ShowPhotoViewController: MailMessageHelperDelegate {
    func messageSentSuccess(){
        UIAlertController.presentCustomAlertControllerWithTitle("Success", message: "Email sent", Button: ["Done"], From: self, WithAction: {_ in })
    }
    
    func messageSentFailure(error:Error){
        UIAlertController.presentCustomAlertControllerWithTitle("Error", message: error.localizedDescription, Button: ["Done"], From: self, WithAction: {_ in })
    }
}
class ShowPhotoViewController: UIViewController {

    @IBOutlet weak var imgvwPhoto: UIImageView!
    var objPhoto:Photo!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = objPhoto.title
        let imgurl = PhotoGalleryUtilities.getPhotoURL(flickrPhoto: objPhoto)
        imgvwPhoto.af_setImage(withURL: URL(string: imgurl)!)
        let barbtnShare = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(ShowPhotoViewController.emailFlickerPic))
        self.navigationItem.rightBarButtonItem = barbtnShare
    }
    
    /// Action on click of share email barbutton
    func emailFlickerPic(){
        let mail = MailMessageHelper()
        mail.delegate = self
        mail.sendEmailWithAttachment(senderVC: self, mailMessage: MailMessage(toRecipients: [""], subject: objPhoto.title!, messageBody: "", imageAttachment: imgvwPhoto.image!)!)
    }
    
    @IBAction func saveImageToPhotoGallery(_ sender: Any) {
        if(imgvwPhoto.image != nil){
            UIImageWriteToSavedPhotosAlbum(imgvwPhoto.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            UIAlertController.presentCustomAlertControllerWithTitle("Success", message: "Image saved to Photo Gallery", Button: ["Done"], From: self, WithAction: {_ in })
        } else {
            UIAlertController.presentCustomAlertControllerWithTitle("Error", message: (error?.localizedDescription)!, Button: ["Done"], From: self, WithAction: {_ in })
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
