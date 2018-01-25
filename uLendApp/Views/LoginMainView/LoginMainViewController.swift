//
//  LoginMainViewController.swift
//  uLendApp
//
//  Created by Manu on 11/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginMainViewController: UIViewController {
    
    enum Mode {
        case login
        case create
    }

    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordRepeatTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var newUserButton: UIButton!
    
    let serviceAuth = Service_Auth()
    var mode = Mode.login
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordRepeatTextField.alpha = 0.0
        passwordRepeatTextField.backgroundColor = UIColor.orange
        
        
        
        //datos de pruebas
        usernameTextField.text = "prueba@prueba.com"
        passwordTextField.text = "prueba"
        passwordRepeatTextField.text = "prueba"
        
        mode = .login
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //si ya está loqueado vamos a la pantalla principal
        guard Auth.auth().currentUser == nil else {
            performSegue(withIdentifier: "showMain", sender: nil)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func loginPressed(_ sender: Any) {
        if mode == .create {
            //verificamos correo, password más de 6, mismo password y lanzamos creación
            if !verifyEmail() { return }
            if !verifyLongPass() { return }
            if !verifySamePass() { return }

            // pasados todos los if iniciamos la creación
            serviceAuth.createUser(usernameTextField.text, passwordTextField.text, completionHandler: { (errorString, user) in
                if errorString == nil {
                    //se ha creado el usuario, nos vamos a la pantalla principal
                    self.performSegue(withIdentifier: "showMain", sender: nil)
                } else {
                    self.present(errorAlertView(errorString), animated: true, completion: nil)
                }
            })
            
            
        } else {
            
            //verificamos usuario correo
            if !verifyEmail() { return }
            //verificamos longitud de password
            if !verifyLongPass() { return }
            
            //pasados estos dos iniciamos login
            serviceAuth.loginUser(usernameTextField.text, passwordTextField.text, completionHandler: { (errorString, user) in
                if errorString == nil {
                    //se ha logueado el usuario nos vmos a pantalla principal
                    self.performSegue(withIdentifier: "showMain", sender: nil)

                } else {
                    self.present(errorAlertView(errorString), animated: true, completion: nil)
                }
            })
        }
    }
    

    
    
    @IBAction func newUserPressed(_ sender: Any) {
        if mode == .login {
            mode = .create
            loginButton.setTitle("Create", for: .normal)
            newUserButton.setTitle("Cancel New User", for: .normal)
            newUserButton.backgroundColor = UIColor.red
            newUserButton.tintColor = UIColor.white
            passwordRepeatTextField.alpha = 1.0
            passwordRepeatTextField.text = ""
            
        } else {
            mode = .login
            loginButton.setTitle("Login", for: .normal)
            newUserButton.setTitle("Nuevo Usuario", for: .normal)
            newUserButton.backgroundColor = UIColor.orange
            newUserButton.tintColor = UIColor.darkText
            passwordRepeatTextField.alpha = 0.0
            
        }
    }
}












extension LoginMainViewController {
    
    func verifyEmail() -> Bool {
        if !isValidEmail(test: usernameTextField.text!){
            present(errorAlertView("Debes introducir un email válido"), animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func verifyLongPass() -> Bool {
        if (passwordTextField.text?.count)! < 6 {
            present(errorAlertView("El password debe tener mínimo 6 caracteres"), animated: true, completion: nil)
            passwordTextField.text = ""
            passwordRepeatTextField.text = ""
            return false
        }
        return true
    }
    
    func verifySamePass() -> Bool {
        if passwordTextField.text != passwordRepeatTextField.text {
            present(errorAlertView("Debes introducir el mismo password"), animated: true, completion: nil)
            passwordTextField.text = ""
            passwordRepeatTextField.text = ""
            return false
        }
        return true
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordRepeatTextField.resignFirstResponder()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMain" {
            
            
            
            
        }
    }
    
    
//
//        func probandoAlgolia(){
//
//            let obj1 = ["firstname": "Jimmie", "lastname": "Barninger"]
//            let obj2 = ["firstname": "Warren", "lastname": "Speach"]
//
//            Service_Algolia().refCreateItems.addObjects([obj1,obj2]) { (content, error) in
//                if error == nil {
//                    print("Object Ids: \(content!)")
//                } else {
//                    print(error?.localizedDescription)
//                }
//            }
//        }

    
    
}

