//
//  Service_Loan.swift
//  uLendApp
//
//  Created by Manu on 6/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import Firebase

struct ULServ_Loan {
    
    private let servDB = ULServ_DB().collectionsLoans
    
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
    
    
    
//    enum loanstatus {
//        case ordered    -> el primero
//        case accepted    -> modifica el ownerItem
//        case loaned       -> modifica el receiver
//        case toreturn     -> modifica el receiver
//        case closed      -> modifica el owner
//        case cancelled    --> modifica el receiver
//        case denied       -> modifica el owner
//    }

    private func verifyChangeToAccepted(_ loan: Loan!, _ userID: String!) -> Bool{
        
        if loan.ownerUser?.uid == userID && loan.status == loanstatus.ordered {
            return true
        }
        return false
    }
    
    private func verifyChangeToCancel(_ loan: Loan!, _ userID: String!) -> Bool {
        
        if loan.ownerUser?.uid == userID && loan.status == loanstatus.ordered {
            return true
        }
        return false
    }
    
    private func verifyChangeToLoaned(_ loan: Loan!, _ userID: String!) -> Bool {
        
        if loan.loanUser?.uid == userID && loan.status == loanstatus.accepted {
            return true
        }
        return false
    }
    
    private func verifyChangeToReturn(_ loan: Loan!, _ userID: String!) -> Bool {
        
        if loan.loanUser?.uid == userID && loan.status == loanstatus.loaned {
            return true
        }
        return false
    }
    private func verifyChangeToCancelled(_ loan: Loan!, _ userID: String!) -> Bool {
        
        if loan.loanUser?.uid == userID && loan.status == loanstatus.ordered {
            return true
        }
        return false
    }
    
    private func verifyChangeToDenied(_ loan: Loan!, _ userID: String) -> Bool {
        if loan.ownerUser?.uid == userID && loan.status == loanstatus.ordered {
            return true
        }
        
        return false
    }
    
    
    
    //reeescribir con un switch para hacerlo más ameno    ^^^^^^^^^^^^
    
    
    func changeStatus(_ loan: Loan!,_ status: loanstatus, completionHandler:@escaping CompletionBool){
        let profile : ProfileAnyHashable = [
            "status":status,
            "lastChange": FieldValue.serverTimestamp()
            ]
        servDB.document(loan.uid).updateData(profile) { (error) in
            if error != nil {
                completionHandler(error?.localizedDescription, false)
            } else {
                completionHandler(nil, true)
            }
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
}
