//
//  pruebalogingoogleViewController.swift
//  uLendApp
//
//  Created by Manu on 22/2/18.
//  Copyright © 2018 Manu. All rights reserved.
//


//
//  ViewController.swift
//  PowerGuard
//
//  Created by David Martín Sáiz on 2/2/18.
//  Copyright © 2018 David Martín Sáiz. All rights reserved.
//

import UIKit
import GoogleSignIn



class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    //MARK: -
    //MARK: Variables
    var control = true
    var controlPosicion = true
    var prueba = false
    
    
    //MARK: -
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        // Uncomment to automatically sign in the user.
//        GIDSignIn.sharedInstance().signInSilently()
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lbUser.resignFirstResponder()
        lbPass.resignFirstResponder()
        
        if(!controlPosicion){ UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
            controlPosicion = true
        }
        
    }
    
    
    //MARK: -
    //MARK: Outlets
    @IBOutlet weak var lbUser: UITextField!
    
    @IBOutlet weak var lbPass: UITextField!
    
    //MARK: -
    //MARK: Acciones
    @IBAction func apareceTecladoMover(_ sender: Any) {
        
        if(controlPosicion){ UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            
        })
            controlPosicion = false
        }
        
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
        //        performSegue(withIdentifier: "userLogin", sender: nil)
    }
    
    

    @IBAction func out(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    
}


//MARK: -
//MARK: Extension
extension LoginViewController{
    

    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
//            present(pg_errorAlertView(error.localizedDescription), animated: true, completion: nil)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15
        ) {
            self.performSegue(withIdentifier: "userLogin", sender: nil)
        }

    }
    
    
}


