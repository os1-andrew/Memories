//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Andrew Liao on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import Photos

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    func updateView(){
        if let memory = memory {
            self.title = "Edit Memory"
            imageView.image = UIImage(data: memory.imageData)
            titleLabel.text = memory.title
            notesField.text = memory.bodyText
        } else {
            self.title = "Add Memory"
        }
    }
    
    //MARK: - Image picking
    func presentImagePickerController(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
    }
    
    //MARK: - Properties
    @IBAction func addPhoto(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            presentImagePickerController()
        }
        if authorizationStatus == .notDetermined{
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized{
                    self.presentImagePickerController()
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var notesField: UITextView!
    
    var memory: Memory?
    var memoryController: MemoryController?
}
