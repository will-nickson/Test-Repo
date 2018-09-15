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
    
    let albumService = AlbumService()
    
    var albums: [AlbumEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
//        tableView.delegate = self
        
        setupUI()
        
        albumService.getAll { albums in
            self.albums = albums
            self.tableView.reloadData()
            print("albums: ", albums)
        }

    }
    
    private func setupUI() {
        tableView.tableFooterView = UIView()
    }
}

