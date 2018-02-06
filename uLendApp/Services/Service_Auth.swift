//
//  Service_Auth.swift
//  uLendApp
//
//  Created by Manu on 11/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import FirebaseAuth

class Service_Auth {
    
    private static let _shared = Service_Auth()
    
    static var shared: Service_Auth {
        return _shared
    }
    
    
    
    func createUser(_ email: String!, _ psswd: String!, completionHandler: @escaping CompletionUserFirebase){
        
        
        Auth.auth().createUser(withEmail: email, password: psswd) { (user, error) in
            
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            }
            if user?.uid != nil {
                //realizamos login al user
                Auth.auth().signIn(withEmail: email, password: psswd, completion: { (user, error) in
                    if let error = (error as NSError?){
                        completionHandler(error.localizedDescription, nil)
                    } else {
                        
                        //se ha creado el user, creamos el profile
                        Service_User().createUser(user?.uid, completionHandler: { (error, bool) in
                            if error != nil {
                                print(error as Any)
                            }
                            
                            
                            
                            
                            
                            
                            
                        })
                        completionHandler(nil, user)
                    }
                })
            }
        }
    }
    
    
    
    
    func loginUser(_ email: String!, _ psswd: String!, completionHandler: @escaping CompletionUserFirebase){
        Auth.auth().signIn(withEmail: email, password: psswd) { (user, error) in
            if let error = (error as NSError?){
                completionHandler(error.localizedDescription, nil)
            } else {
                completionHandler(nil, user)
            }
        }
    }
    
    
    
    
    
    
}
