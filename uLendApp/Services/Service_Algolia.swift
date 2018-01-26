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
 
    
    private static let clientSearch = Client(appID: AlgoliaKeys.appId, apiKey: AlgoliaKeys.apiKeySearch)
    private static let clientAdmin = Client(appID: AlgoliaKeys.appId, apiKey: AlgoliaKeys.apiKeyAdmin)
    
    var refSerchUser = clientSearch.index(withName: "users")
    var refCreateUser = clientAdmin.index(withName: "users")

    var refSearchItems = clientSearch.index(withName: "items")
    var refCreateItems = clientAdmin.index(withName: "items")
    
}


// MARK: functions
extension Service_Algolia {
    
    func saveItem(_ item: Item!, _ CompletionHandlerSaveItem: @escaping CompletionAlgoliaItem){
        
        let itemAl = ["uid": item.uid ?? "", "name": item.name ?? "", "description": item.description ?? ""]

        refCreateItems.addObject(itemAl, withID: item.uid!, requestOptions: nil) { (content, error) in
            if error == nil {
                CompletionHandlerSaveItem(nil, content)
            } else {
                CompletionHandlerSaveItem(error?.localizedDescription, nil)
            }
        }
        
        
    }
    
    
    
    
}






