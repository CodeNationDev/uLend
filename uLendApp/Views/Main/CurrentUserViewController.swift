//
//  CurrentUserViewController.swift
//  uLendApp
//
//  Created by Manu on 16/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import FirebaseAuth

class CurrentUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(){
        presentAlert()
    }
    
    
    func presentAlert(){
        let alert = UIAlertController(title: "Sign Out", message: "Desconectar sesión", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Disconect", style: .default) { (action) in

            if !self.disconect() {
                let alert = errorAlertView("Ha pasado algo raro raro raro, vuelve a probar de desconectar la sesión.")
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "signedOut", sender: nil)

            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
// no hacemos nah de nah
            
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func disconect() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
            
        } catch {
            return false
        }
        
        
    }

}
