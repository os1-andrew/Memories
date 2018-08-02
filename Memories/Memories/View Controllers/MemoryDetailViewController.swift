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
            addPhotoButton.setTitle("Change Photo", for: .normal)
            
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
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image,
            let title = titleLabel.text,
            let bodyText = notesField.text,
            let imageData = UIImagePNGRepresentation(image) else {return}
        
        
        if let memory = memory {
            memoryController?.update(for: memory, title: title, bodyText: bodyText, imageData: imageData)
        } else {
            memoryController?.createMemory(withTitle: title, bodyText: bodyText, imageData: imageData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var notesField: UITextView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    var memory: Memory?
    var memoryController: MemoryController?
}
