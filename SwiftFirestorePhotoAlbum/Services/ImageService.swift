//
//  ImageService.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 18/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation
import FirebaseStorage

class ImageService {
    private init() {}
    
    static let shared = ImageService()
    
    func getImages(completion: @escaping ([Data]) -> ()) {
        
        let storage = Storage.storage()
        
        storage.reference(withPath: "images").child("lol.jpg").downloadURL { (url, error) in
            print("get images yaya: ", url ?? "No URL", error?.localizedDescription)
            
            let imagesData = [Data]()
            completion(imagesData)
        }
    }
}
