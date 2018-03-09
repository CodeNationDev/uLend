//
//  Service_Storage.swift
//  uLendApp
//
//  Created by Manu on 13/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase


struct ULServ_Storage {
    private let storageRef = Storage.storage().reference()
    
    var itemImagesRef : StorageReference {
        return storageRef.child("images").child("items")
    }
    
    
    func deleteImagesByUIDItem(_ uidItem: String!, _ count: Int){
        
        
        
        for x in 1...count {
            let imageName = "image\(x).jpg"
            let delete = self.itemImagesRef.child(uidItem).child(imageName)
            
            delete.delete(completion: { (error) in
                if let error = error {
                    
                } else {
                    
                }
            })

        }
        
        
        
        
    }
    
    
    
    
    
}
