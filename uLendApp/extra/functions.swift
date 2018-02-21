//
//  functions.swift
//  uLendApp
//
//  Created by Manu on 11/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import Foundation
import UIKit



/**
 Verify if is a valid email
 @param: email
 */
public func ULF_isValidEmail(test: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: test)
}



public func ULF_errorAlertView(_ message: String!) -> UIAlertController{
    let alertVC = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertVC.addAction(defaultAction)
    return alertVC
}



