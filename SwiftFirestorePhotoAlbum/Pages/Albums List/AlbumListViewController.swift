//
//  AlbumListViewController.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 03/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var albums: [AlbumEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        AlbumService.shared.getAll { albums in
            self.albums = albums
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupUI() {
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumDetailsSegue", let index = sender as? Int, let albumDetailsController = segue.destination as? AlbumDetailsViewController, let album = albums?[index] {
            albumDetailsController.album = album
        }
    }
}

