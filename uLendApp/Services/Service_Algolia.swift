//
//  Service_Algolia.swift
//  uLendApp
//
//  Created by Manu on 20/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import AlgoliaSearch

struct Service_Algolia {
 
    
    private static let clientSearch = Client(appID: "T2NW9U3W9F", apiKey: "c9ad5cd8c4a29789099c7501561228dc")
    private static let clientAdmin = Client(appID: "T2NW9U3W9F", apiKey: "3934242ed5979c45ef9fb3ec062429ea")

    static var refSearchUser: Index {
        return clientSearch.index(withName: "users")
    }
    static var refCreateUser: Index {
        return clientAdmin.index(withName: "users")
    }
    
    var refCreateItems = clientAdmin.index(withName: "items")
//    static var refCreateItems: Index {
//        return clientAdmin.index(withName: "items")
//    }
    
    static var refSerchItems: Index {
        return clientSearch.index(withName: "items")
    }
    
}






