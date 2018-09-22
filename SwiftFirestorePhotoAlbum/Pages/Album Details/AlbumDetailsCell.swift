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
    
    override func awakeFromNib() {
        setupCell()
    }
    
    private func setupCell() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8
    }
    
    func configure(image: UIImage?) {
        self.imageView.image = image
        
        if image != nil {
            self.activityIndicator.stopAnimating()
        } else {
            self.activityIndicator.startAnimating()
        }
    }
}
