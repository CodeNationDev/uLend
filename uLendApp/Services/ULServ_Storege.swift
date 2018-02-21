//
//  Service_Storage.swift
//  uLendApp
//
//  Created by Manu on 13/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase


struct ULServ_Storege {
    private let storageRef = Storage.storage().reference()
    
    var itemImagesRef : StorageReference {
        return storageRef.child("images").child("items")
    }
    
    
}
