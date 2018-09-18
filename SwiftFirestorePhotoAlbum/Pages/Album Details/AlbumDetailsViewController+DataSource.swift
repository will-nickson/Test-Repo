//
//  AlbumDetailsViewController+DataSource.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 16/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

extension AlbumDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumDetailsCell", for: indexPath)
        return cell
    }
}
