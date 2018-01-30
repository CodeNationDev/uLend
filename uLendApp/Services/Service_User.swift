//
//  Service_User.swift
//  uLendApp
//
//  Created by Manu on 30/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase

final class Service_User {
    
    private let servDB = Service_Database()
    
    func createUser(_ uidUser: String!, completionHandler: @escaping CompletionBool){
        
        let profile = [
            "name":"your name",
            "surname":"your surname"
        ]
        servDB.collectionUsers.document(uidUser).setData(profile) { (error) in
            if let error = error {
                completionHandler(error.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
        }
    }
    
    
    
}
