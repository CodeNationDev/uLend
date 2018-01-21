//
//  Typealias.swift
//  uLendApp
//
//  Created by Manu on 11/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias Profile = Dictionary<String, AnyObject>

typealias CompletionAnyObject = (_ error: String?, _ data: AnyObject?) -> Void
typealias CompletionUserFirebase = (_ error: String?, _ data: User?) -> Void

//typealias CompletionItem = (_ error: String?, _ data: Item?) -> Void
//typealias CompletionArrayItems = (_ error: String?, _ data: [Item]?) -> Void
//typealias CompletionArrayLoans = (_ error: String?, _ data: [Loan]?) -> Void
typealias CompletionBool = (_ error: String?, _ data: Bool) -> Void


