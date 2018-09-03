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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        albumService.getAll { albums in
            print("albums: ", albums)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func setupUI() {
        tableView.tableFooterView = UIView()
    }
}

