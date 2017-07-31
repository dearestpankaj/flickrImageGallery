//
//  MailMessageHelper.swift
//  FlickrApp
//
//  Created by Pankaj Sachdeva on 7/31/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import UIKit
import MessageUI

protocol MailMessageHelperDelegate {
    func messageSentSuccess()
    func messageSentFailure(error:Error)
}
extension MailMessageHelper: MFMailComposeViewControllerDelegate {
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            self.delegate?.messageSentFailure(error: ErrorHelper.error("User cancelled email"))
        case .saved:
            self.delegate?.messageSentFailure(error: ErrorHelper.error("Email saved in drafts"))
        case .sent:
            self.delegate?.messageSentSuccess()
            break
        case .failed:
            self.delegate?.messageSentFailure(error: ErrorHelper.error("Email sent failed"))
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

class MailMessageHelper: NSObject {
    var delegate : MailMessageHelperDelegate?
    var mailComposeViewController = MFMailComposeViewController()
    
    /// Send email with attachement
    ///
    /// - Parameters:
    ///   - senderVC: sender UIViewController
    ///   - mailMessage: MailMessage object
    func sendEmailWithAttachment(senderVC: UIViewController, mailMessage:MailMessage) {
//        mailComposeViewController = configuredMailComposeViewController(mailMsg: mailMessage)
        mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(mailMessage.toRecipients)
        mailComposeViewController.setSubject(mailMessage.subject!)
        let imageData = UIImageJPEGRepresentation(mailMessage.imageAttachment, 1)
        mailComposeViewController.addAttachmentData(imageData!, mimeType:"image/jpeg", fileName:"Image")
        mailComposeViewController.setMessageBody(mailMessage.messageBody!, isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            senderVC.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    /// compose mail message
    ///
    /// - Parameter mailMsg: MailMessage object
    /// - Returns: MFMailComposeViewController
    private func configuredMailComposeViewController(mailMsg:MailMessage) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(mailMsg.toRecipients)
        mailComposerVC.setSubject(mailMsg.subject!)
        let imageData = UIImageJPEGRepresentation(mailMsg.imageAttachment, 1)
        mailComposerVC.addAttachmentData(imageData!, mimeType:"image/jpeg", fileName:"Image")
        mailComposerVC.setMessageBody(mailMsg.messageBody!, isHTML: false)
        
        return mailComposerVC
    }
}
