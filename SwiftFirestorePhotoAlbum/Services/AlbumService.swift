//
//  AlbumService.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 03/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class AlbumService {
    
    private init() {}
    
    static let shared = AlbumService()
    
    func getAll(albums: @escaping ([AlbumEntity]) -> ()) {
        let albumsCollection = Firestore.getFirestore().albums()
        
        albumsCollection.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("error getting albums: ", error.localizedDescription)
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                print("empty querySnapshot")
                return
            }
            
            let albumList = querySnapshot.documents
                .map { AlbumEntity(id: $0.documentID, data: $0.data() ) }
            
            DispatchQueue.main.async {
                albums(albumList)
            }
        }
    }
    
    func upload(images: [Data], albumId: String, completion: @escaping () -> ()) {
        let imagesWithIds = images
            .map { (id: UUID().uuidString, imageData: $0) }
        
        let albumDocument = Firestore.getFirestore().album(id: albumId)
        
//        let imagesIds = imagesWithIds.map { $0.id }
//        albumDocument.updateData(["images": imagesIds])
        
        let imagesRef = Storage.storage().reference(withPath: "images")
        
        imagesWithIds.forEach { (id, imageData) in
            let imageRef = imagesRef.child(id)
            imageRef.putData(imageData, metadata: nil, completion: { (meta, error) in
                if let error = error {
                    print("error: ", error.localizedDescription)
                    return
                }
                
                imageRef.downloadURL(completion: { (url, error) in
                    imageRef.downloadURL(completion: { (url, error) in
                        if let error = error {
                            print("error: ", error.localizedDescription)
                            return
                        }
                        
                        albumDocument.updateData(["images": FieldValue.arrayUnion([url!.absoluteString])])
//                        albumDocument.setData(["images": [url!.absoluteString]], merge: true)
                    })
                })
            })
        }
        
        completion()
    }
}
