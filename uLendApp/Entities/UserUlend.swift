//
//  User.swift
//  uLendApp
//
//  Created by Manu on 2/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase

final class UserUlend {
    
    var uid: String!
    var name: String!
    var surname: String!
    var email: String!
    var telephoneNumer: Int?
    var country: String?
    
    
    
    
    
    
    
//    se comenta pues todos los usuarios se tomarán desde un document de firestore
//    queda el init docment como única forma de crear una clase UserUlend
//    init(_ uid: String!, _ name: String!, _ surname: String?){
//        self.uid = uid
//        self.name = name
//        self.surname = surname ?? ""
//        self.email
//    }
    
    init(_ document: DocumentSnapshot){
        self.uid = document.documentID
        self.name = document.get("name") as? String ?? "name"
        self.surname = document.get("surname") as? String ?? "surname"
        self.email = document.get("email") as? String ?? "email@email.com"
        self.telephoneNumer = document.get("telephoneNumber") as? Int ?? 0
        self.country = document.get("country") as? String ?? "no country"
        
        
    }
    
    
    
    
    
}
