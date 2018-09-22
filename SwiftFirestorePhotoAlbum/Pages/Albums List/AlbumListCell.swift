//
//  AlbumListCell.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 22/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    //
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    
    func configure(albumName: String, createdOn: String, numberOfPhotos: String) {
        albumNameLabel.text = albumName
        createdOnLabel.text = createdOn
        numberOfPhotosLabel.text = numberOfPhotos
    }
}
