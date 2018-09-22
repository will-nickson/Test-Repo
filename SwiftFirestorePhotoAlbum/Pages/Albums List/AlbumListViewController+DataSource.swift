//
//  AlbumListViewController+DataSource.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 15/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

extension AlbumListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumListCell
        
        if let album = albums?[indexPath.row] {
            cell.configure(albumName: album.name, createdOn: "12 Mar 2018", numberOfPhotos: "33")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
