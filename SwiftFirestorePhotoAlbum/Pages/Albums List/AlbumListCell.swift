//
//  AlbumListCell.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 22/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "dd MMM YYYY"
    }
    
    func configure(albumName: String, createdOn: Date, numberOfPhotos: Int) {
        albumNameLabel.text = albumName
        createdOnLabel.text = dateFormatter.string(from: createdOn)
        numberOfPhotosLabel.text = String(numberOfPhotos)
    }
}
