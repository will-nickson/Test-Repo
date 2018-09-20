//
//  Storage+Extensions.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 20/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation
import FirebaseStorage

extension Storage {
    func images() -> StorageReference {
        return self.reference(withPath: "images")
    }
    
    func image(id: String) -> StorageReference {
        return self.images().child(id)
    }
}
