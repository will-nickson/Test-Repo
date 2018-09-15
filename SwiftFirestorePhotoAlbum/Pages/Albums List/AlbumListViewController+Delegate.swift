//
//  AlbumListViewController+Delegate.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 15/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import UIKit

extension AlbumListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AlbumDetailsSegue", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
