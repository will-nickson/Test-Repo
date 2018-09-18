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
    
    func getAllImagesFor(albumId: String, images: @escaping ([ImageEntity]) -> ()) {
        let imagesCollection = Firestore.getFirestore().images()
            .whereField("albumId", isEqualTo: albumId)
        
        imagesCollection.addSnapshotListener { (query, error) in
            if let error = error {
                print("error: ", error.localizedDescription)
                return
            }
            
            guard let query = query else { return }
            
            let imagesEntities = query.documents
                .map { ImageEntity(id: $0.documentID, data: $0.data()) }
            
            DispatchQueue.main.async {
                images(imagesEntities)
            }
        }
    }
    
    func upload(images: [Data], albumId: String, completion: @escaping () -> ()) {
        let imagesCollectionRef = Firestore.getFirestore().images()
        
        let imagesWithDocRefs = images
            .map { (docRef: imagesCollectionRef.document(), imageData: $0) }
        
        let createImagesBatch = Firestore.getFirestore().batch()
        
        imagesWithDocRefs.forEach { (docRef, _) in
            let data = ["albumId": albumId, "dateAdded": Timestamp(date: Date()), "status": "pending"] as [String : Any]
            createImagesBatch.setData(data, forDocument: docRef)
        }
        
        createImagesBatch.commit { _ in
            completion()
        }
        
        let imagesRef = Storage.storage().reference(withPath: "images")
        
        imagesWithDocRefs.forEach { (docRef, imageData) in
            let imageRef = imagesRef.child(docRef.documentID)
            
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
                        
                        let data = ["status": "ready", "url": url!.absoluteString] as [String : Any]
                        docRef.updateData(data)
                    })
                })
            })
        }
    }
}
