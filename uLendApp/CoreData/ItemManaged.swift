//
//  ItemManaged.swift
//  uLendApp
//
//  Created by Manu on 15/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation

extension ItemManaged {
    
    func mappedObject() -> Item {
        return Item(self.uid, self.uidOwner, self.name, self.descripcion)
    }
    

}

