//
//  AlbumDetailsCell.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 18/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class AlbumDetailsCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(image: ImageEntity) {
        ImageService.shared.getImageDataFor(imageEntity: image) { data in
            let image = UIImage(data: data)
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
}
