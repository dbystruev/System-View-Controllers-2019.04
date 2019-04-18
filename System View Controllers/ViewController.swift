//
//  ViewController.swift
//  System View Controllers
//
//  Created by Denis Bystruev on 18/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import MessageUI
import SafariServices

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - IB Actions
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        
        let activityController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        present(activityController, animated: true)
    }

    @IBAction func safariButtonTapped(_ sender: UIButton) {
        let url = URL(string: "http://apple.ru")!
        
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                print(#function, "Camera selected")
                // TODO: TODO: Implement camera selection
            }
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
        

        present(alertController, animated: true)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print(#line, #function, "Can not send e-mail")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["dbystruev@swiftbook.ru"])
        mailComposer.setSubject("Please help with my homework")
        mailComposer.setMessageBody("Hello, please help me with the following...", isHTML: false)
        
        present(mailComposer, animated: true)
    }
    
    @IBAction func messageButtonTapped(_ sender: UIButton) {
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let data = info[UIImagePickerController.InfoKey.originalImage] else { return }
        let image = data as? UIImage
        imageView.image = image
        dismiss(animated: true)
    }
}

// MARK: - MFMailComposeViewControllerDelegate
extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}
