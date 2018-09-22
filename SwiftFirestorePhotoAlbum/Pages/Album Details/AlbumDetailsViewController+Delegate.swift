//
//  AlbumDetailsViewController+Delegate.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 20/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

extension AlbumDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PhotoDetailsSegue", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if imageEntities?.count ?? 0 > indexPath.row, let imageEntity = imageEntities?[indexPath.row], let imageTask = imageTasks[imageEntity.imageId] {
            imageTask.resume()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if imageEntities?.count ?? 0 > indexPath.row, let imageEntity = imageEntities?[indexPath.row], let imageTask = imageTasks[imageEntity.imageId] {
            imageTask.pause()
        }
    }
}
