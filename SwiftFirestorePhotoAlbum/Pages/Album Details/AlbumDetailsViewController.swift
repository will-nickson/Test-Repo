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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = album.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPhotosSegue", let selectPhotosController = segue.destination.childViewControllers.first as? SelectPhotosViewController {
            selectPhotosController.album = album
        }
    }
}
