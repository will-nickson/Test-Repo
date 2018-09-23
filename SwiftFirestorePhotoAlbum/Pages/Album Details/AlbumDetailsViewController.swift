//
//  AlbumDetailsViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 15/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AlbumDetailsViewController: UIViewController, ImageTaskDownloadedDelegate {
    var album: AlbumEntity!
    var imageEntities: [ImageEntity]?
    var imageTasks = [String: ImageTask]()
    var queryListener: ListenerRegistration!
    
    var selectedPhoto: (index: Int, photoDetailsController: PhotoDetailsViewController)?
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        self.title = album.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedPhoto = nil
        
        queryListener = ImageService.shared.getAllImagesFor(albumId: album.albumId) { [weak self] images in
            guard let strongSelf = self else { return }
            strongSelf.imageEntities = images
            strongSelf.updateImageTasks()
            
            if images.isEmpty {
                strongSelf.collectionView.addNoDataLabel(text: "No Photos added yet.\n\nPlease press Add button to begin")
            } else {
                strongSelf.collectionView.removeNoDataLabel()
            }
            
            strongSelf.collectionView.reloadData()
            strongSelf.activityIndicator.stopAnimating()
        }
    }
    
    func updateImageTasks() {
        imageEntities?.forEach { imageEntity in
            if imageEntity.status == .ready, imageTasks[imageEntity.imageId] == nil, let urlStr = imageEntity.url, let url = URL(string: urlStr) {
                imageTasks[imageEntity.imageId] = ImageTask(id: imageEntity.imageId, url: url, session: urlSession, delegate: self)
            }
        }
    }
    
    func imageDownloaded(id: String) {
        if let index = imageEntities?.firstIndex(where: { $0.imageId == id }) {
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            
            if let selectedPhoto = self.selectedPhoto, selectedPhoto.index == index, imageEntities?.count ?? 0 > index, let imageEntity = imageEntities?[index], let imageTask = imageTasks[imageEntity.imageId], let image = imageTask.image {
                selectedPhoto.photoDetailsController.image = image
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        queryListener.remove()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPhotosSegue", let selectPhotosController = segue.destination.childViewControllers.first as? SelectPhotosViewController {
            selectPhotosController.album = album
        } else if segue.identifier == "PhotoDetailsSegue", let photoDetailsController = segue.destination as? PhotoDetailsViewController, let index = sender as? Int, imageEntities?.count ?? 0 > index, let imageEntity = imageEntities?[index] {
            selectedPhoto = (index, photoDetailsController)
            photoDetailsController.imageId = imageEntity.imageId
            photoDetailsController.image = imageTasks[imageEntity.imageId]?.image
        }
    }
}
