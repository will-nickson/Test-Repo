//
//  PhotoDetailsViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 20/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    var imageId: String!
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func deleteHandler(_ sender: Any) {
        activityIndicator.startAnimating()
        
        ImageService.shared.delete(imageId: imageId) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
