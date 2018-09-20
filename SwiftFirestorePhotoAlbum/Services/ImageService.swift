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
    
    func getImageDataFor(imageEntity: ImageEntity, completion: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: URL(string: imageEntity.url!)!) { (data, _, error) in
            if let error = error {
                print("error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                completion(data)
            }
         }.resume()
    }
}
