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
    
    /// update in the document of the user only one label
    ///
    /// - Parameters:
    ///   - uidUser: uid of the user document
    ///   - label: propertie name
    ///   - data: data
    ///   - completionHandler: return true if is ok
    func updateLabel(_ uidUser: String!, _ label: String!, _ data: AnyObject, completionHandler: @escaping CompletionBool){
        
        let profile : Profile = [label:data]
        servDB.collectionUsers.document(uidUser).setData(profile) { (error) in
            if error != nil {
                completionHandler(error?.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
        }

    }
    
    
    
    
    
    
}
