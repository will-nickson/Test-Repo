//
//  ImageEntity.swift
//  SwiftFirestorePhotoAlbum
//
//  Created by Alex Akrimpai on 18/09/2018.
//  Copyright © 2018 Alex Akrimpai. All rights reserved.
//

import Foundation

enum ImageStatus {
    case pending, ready
}

struct ImageEntity {
    let imageId: String
    let status: ImageStatus
    let url: String?
    
    init(id: String, data: [String: Any]) {
        self.imageId = id
        
        let status = data["status"] as? String
        if let status = status?.lowercased() {
            switch status {
            case "pending":
                self.status = .pending
            case "ready":
                self.status = .ready
            default:
                self.status = .pending
            }
        } else {
            self.status = .pending
        }
        
        self.url = data["url"] as? String
    }
}
