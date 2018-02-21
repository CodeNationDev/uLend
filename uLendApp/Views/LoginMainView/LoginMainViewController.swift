//
//  LoginMainViewController.swift
//  uLendApp
//
//  Created by Manu on 11/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginMainViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {


    

    
    enum Mode {
        case login
        case create
    }
    
    @IBOutlet var usernameTextField: YoshikoTextField!
    @IBOutlet var passwordTextField: YoshikoTextField!
    @IBOutlet var passwordRepeatTextField: YoshikoTextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var newUserButton: UIButton!
    @IBOutlet var googleLoginButton: UIButton!
    @IBOutlet var loginView: UIView!
    @IBOutlet var yoLabel: UILabel!
    @IBOutlet var uLabel: UILabel!
    @IBOutlet var lendLabel: UILabel!
    
    let serviceAuth = ULServ_Auth()
    var mode = Mode.login
    var currenUser: UserUlend?
    
    
    var controlPosicion = false

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
        passwordRepeatTextField.alpha = 0.0
        
        
        // Google SignIn
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //datos de pruebas
        usernameTextField.text = "prueba@prueba.com"
        passwordTextField.text = "prueba"
        passwordRepeatTextField.text = "prueba"
        
        mode = .login

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ocultamosItems()
    }




    
    override func viewDidAppear(_ animated: Bool) {
        //si ya está loqueado vamos a la pantalla principal

        if Auth.auth().currentUser == nil {
//            mostramosItems()  DEPRECATED
            animateLogin()
            youLendAnimation()
        } else {
            performSegue(withIdentifier: "showMain", sender: nil)
        }
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
                    self.present(ULF_errorAlertView(errorString), animated: true, completion: nil)
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
                    self.present(ULF_errorAlertView(errorString), animated: true, completion: nil)
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
    
    func ocultamosItems(){
//        usernameTextField.isHidden = true
//        passwordTextField.isHidden = true
//        passwordRepeatTextField.isHidden = true
//        loginButton.isHidden = true
//        newUserButton.isHidden = true
//        googleLoginButton.isHidden = true
        loginView.isHidden = true
        
    }
    func mostramosItems(){
//        usernameTextField.isHidden = false
//        passwordTextField.isHidden = false
//        passwordRepeatTextField.isHidden = false
//        loginButton.isHidden = false
//        newUserButton.isHidden = false
//        googleLoginButton.isHidden = false
        loginView.isHidden = false
    }
    
    
    func verifyEmail() -> Bool {
        if !ULF_isValidEmail(test: usernameTextField.text!){
            present(ULF_errorAlertView("Debes introducir un email válido"), animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func verifyLongPass() -> Bool {
        if (passwordTextField.text?.count)! < 6 {
            present(ULF_errorAlertView("El password debe tener mínimo 6 caracteres"), animated: true, completion: nil)
            passwordTextField.text = ""
            passwordRepeatTextField.text = ""
            return false
        }
        return true
    }
    
    func verifySamePass() -> Bool {
        if passwordTextField.text != passwordRepeatTextField.text {
            present(ULF_errorAlertView("Debes introducir el mismo password"), animated: true, completion: nil)
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
        
        if controlPosicion {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
            })
            controlPosicion = false
        }
    }
    
    @IBAction func apareceTecladoMover(_ sender: Any) {
        
        if(!controlPosicion){ UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height);
        })
            controlPosicion = true
        }
    }
}

//MARK: Animation login

extension LoginMainViewController {
    func animateLogin(){
        mostramosItems()
        loginView.alpha = 0
        loginView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        let position = loginView.center
        loginView.center = CGPoint(x: loginView.center.x, y: loginView.center.y + 500)
    
        UIView.animate(withDuration: 0.5) {
            self.loginView.alpha = 1
            self.loginView.transform = CGAffineTransform.identity
            self.loginView.center = position
        }
    
    }
    
    
    
    
    func youLendAnimation() {
        
        //hacemos copia de valores
        
        let yoLabelCenter = yoLabel.center
        let uLabelCenter = uLabel.center
        let lendLabelCenter = lendLabel.center
        
        //resituamos los elemenos
        //yo u arriba
        // lend a derecha
        
        yoLabel.center = CGPoint(x: yoLabel.center.x, y: -10)
        uLabel.center = CGPoint(x: uLabel.center.x, y: -10)
        lendLabel.center = CGPoint(x: 800, y: lendLabel.center.y)
    
        UIView.animate(withDuration: 0.8, animations: {
            //yo u   -> para abajo
            self.yoLabel.center = yoLabelCenter
            self.uLabel.center = uLabelCenter
        }) { (bool) in
            UIView.animate(withDuration: 0.8, animations: {
                // lend ->  a izquierda
                self.lendLabel.center = lendLabelCenter
                
                
            }, completion: { (bool) in
                UIView.animate(withDuration: 0.5, animations: {
                    //yo -> sale de pantalla
                    self.yoLabel.center = CGPoint(x: -100, y: self.yoLabel.center.y)
                })
            })
        }
    }
}





//MARK: Google Signin
extension LoginMainViewController {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            present(ULF_errorAlertView(error.localizedDescription), animated: true, completion: nil)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = (error as NSError?){
                print(error.localizedDescription)
                self.present(ULF_errorAlertView(error.localizedDescription), animated: true, completion: nil)
                return
            }
            
            ULServ_User().createUser(user?.uid, completionHandler: { (error, bool) in
                if error != nil {
                    print(error as Any)
                }
            })
            self.performSegue(withIdentifier: "showMain", sender: nil)
        }
    }
    
    @IBAction func googleButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
}


