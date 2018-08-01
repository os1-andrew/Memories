//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by Andrew Liao on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class MemoryDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addPhoto(_ sender: Any) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var notesField: UITextView!
}
