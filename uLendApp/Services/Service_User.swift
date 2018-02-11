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
        
        let profile: ProfileAnyHashable = [
            "name":"your name",
            "surname":"your surname",
            "creationDate": FieldValue.serverTimestamp(),
            "email": (Auth.auth().currentUser?.email)!
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
    func updateLabel(_ uidUser: String!, _ label: String!, _ data: Any, completionHandler: @escaping CompletionBool){
       
        var profile = Profile()

        profile[label] = data
        profile["lastUpdated"] = FieldValue.serverTimestamp()

        servDB.collectionUsers.document(uidUser).updateData(profile) { error in
            if let error = error {
                completionHandler(error.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
        }
        
    }
    
    
    
    func getDataCurrentUser(_ uidUser: String!, completionHandler: @escaping CompletionUser){
        servDB.collectionUsers.document(uidUser).getDocument { (document, error) in
            if let error = error {
                completionHandler(error.localizedDescription, nil)
            }
            let currentUser = UserUlend(document!)
            completionHandler(nil, currentUser)
        }
    }
    
    
    
    
    
    
}
