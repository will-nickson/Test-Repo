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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageService.shared.getImageDataFor(imageEntity: image) { data in
            let image = UIImage(data: data)
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func deleteHandler(_ sender: Any) {
        activityIndicator.startAnimating()
        
        ImageService.shared.delete(imageId: image.imageId) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
