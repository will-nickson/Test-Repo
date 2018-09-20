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
}
