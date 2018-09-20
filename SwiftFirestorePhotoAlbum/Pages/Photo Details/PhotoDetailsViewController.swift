//
//  PhotoDetailsViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 20/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    var image: ImageEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("image: ", image)
    }
}
