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
    
    func addAlbumWith(name: String) {
        let albumsCollection = Firestore.getFirestore().albums()
        let data = ["name": name, "dateCreated": Timestamp(date: Date())] as [String : Any]
        albumsCollection.addDocument(data: data)
    }
    
    func deleteAlbumWith(albumId: String) {
        Firestore.getFirestore().album(id: albumId).delete()
        ImageService.shared.deleteAllImagesFor(albumId: albumId)
    }
    
    func getAll(albums: @escaping ([AlbumEntity]) -> ()) -> ListenerRegistration {
        let albumsCollection = Firestore.getFirestore().albums()
            .order(by: "dateCreated")
        
        return albumsCollection.addSnapshotListener { query, error in
            guard let query = query else {
                if let error = error {
                    print("error getting albums: ", error.localizedDescription)
                }
                return
            }
            
            let albumList = query.documents
                .map { AlbumEntity(id: $0.documentID, data: $0.data() ) }
            
            DispatchQueue.main.async {
                albums(albumList)
            }
        }
    }
}
