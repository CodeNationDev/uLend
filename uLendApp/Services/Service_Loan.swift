//
//  Service_Loan.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase

struct Service_Loan {
    
    private let servDB = Service_Database().collectionsLoans
    
    func createLoan(_ item: Item!,_ userOwner: UserUlend!, _ userLoan: UserUlend!, completionHandler: @escaping CompletionLoan){
        
        let profile : ProfileAnyHashable = [
        
            "UIDItem": item.uid!,
            "UIDOwnerUser": item.uidOwner!,
            "UIDUserLoan": userLoan.uid,
            "createdData" : Date().description,
            "status" : loanstatus.ordered
            
            
        
        
        ]
        
        var ref: DocumentReference? = nil
            ref = servDB.addDocument(data: profile) { (error) in
            if error != nil {
                print("error creating loan")
                completionHandler(error?.localizedDescription, nil)
            } else {
                
            let loan = Loan(ref?.documentID, item, userOwner, userLoan)
            completionHandler(nil, loan)
                
            }
        }
        
    }
    
    
    func changeStatus(_ status: loanstatus, completionHandler:@escaping CompletionBool){
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
