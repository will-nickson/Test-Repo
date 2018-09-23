//
//  AlbumEntity.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 03/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation

struct AlbumEntity {
    let albumId: String
    let name: String
    let dateCreated: Date
    let numberOfPhotos: Int
    
    init(id: String, data: [String: Any]) {
        self.albumId = id
        self.name = data["name"] as? String ?? ""
        self.dateCreated = data["dateCreated"] as? Date ?? Date.init()
        self.numberOfPhotos = data["numberOfPhotos"] as? Int ?? 0
    }
}
