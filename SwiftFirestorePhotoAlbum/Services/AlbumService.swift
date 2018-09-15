//
//  AlbumService.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 03/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation
import FirebaseFirestore

class AlbumService {
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
}
