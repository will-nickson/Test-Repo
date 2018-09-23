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
            if imageView != nil, activityIndicator != nil, let image = image {
                set(image: image)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            set(image: image)
        }
    }
    
    private func set(image: UIImage) {
        imageView.image = image
        activityIndicator.stopAnimating()
    }
    
    @IBAction func deleteHandler(_ sender: Any) {
        activityIndicator.startAnimating()
        
        ImageService.shared.delete(imageId: imageId) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
