//
//  Loan.swift
//  uLendApp
//
//  Created by Manu on 2/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation

final class Loan {
    
    var uid: String!
    var item: Item!
    var ownerUser: UserUlend?
    var loanUser: UserUlend?
    
    var status: loanstatus!
    var petitiondate: String!
    
    
    init(_ uid: String!, _ item: Item!, _ ownerUser: UserUlend!, _ loanUser: UserUlend!){
        self.uid = uid
        self.item = item
        self.ownerUser = ownerUser
        self.loanUser = loanUser
        
        self.status = loanstatus.ordered
        self.petitiondate = Date().description
    }
    

    
    
    
}




