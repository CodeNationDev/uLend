//
//  ItemSelectedViewController.swift
//  uLendApp
//
//  Created by Manu on 28/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

class ItemSelectedViewController: UIViewController {

    var hola = "hola"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(hola)
    }

    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
