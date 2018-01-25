//
//  Service_Database.swift
//  uLendApp
//
//  Created by Manu on 22/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase

class Service_Database {
    
//    private static let _shared = Service_Database()
    
//    let shared = _shared
    let mainDB = Firestore.firestore()

    
    var collectionUsers : CollectionReference {
        return mainDB.collection("users")
    }
    
    var collectionItems : CollectionReference {
        return mainDB.collection("items")
    }
    
    var collectionsLoans : CollectionReference {
        return mainDB.collection("loans")
    }

}
