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
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumDetailsCell", for: indexPath) as! AlbumDetailsCell
        
        if let images = images, images.count > indexPath.row {
            let image = images[indexPath.row]
            
            if image.status == .ready {
                cell.configure(image: image)
            }
        }
        
        return cell
    }
}
