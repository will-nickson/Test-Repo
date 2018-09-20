//
//  AlbumDetailsViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 15/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    var album: AlbumEntity!
    var images: [ImageEntity]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = album.name
        
        AlbumService.shared.getAllImagesFor(albumId: album.albumId) { [weak self] images in
            guard let strongSelf = self else { return }
            strongSelf.images = images
            strongSelf.collectionView.reloadData()
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPhotosSegue", let selectPhotosController = segue.destination.childViewControllers.first as? SelectPhotosViewController {
            selectPhotosController.album = album
        } else if segue.identifier == "PhotoDetailsSegue", let photoDetailsController = segue.destination as? PhotoDetailsViewController, let index = sender as? Int, images?.count ?? 0 > index, let imageEntity = images?[index] {
            photoDetailsController.image = imageEntity
        }
    }
}
