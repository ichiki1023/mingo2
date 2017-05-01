//
//  LoginViewController.swift
//  mingo2
//
//  Created by valurate.mac on 2017/04/13.
//  Copyright © 2017年 valurate. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var emailtextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    

    
    
    
    @IBAction func createNewUser(_ sender: Any) {
        
        if emailtextField.text == nil || passwordTextField.text == nil{
            
            let alertViewControler = UIAlertController(title: "おっと", message: "入力欄が空の状態です！", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertViewControler.addAction(okAction)
            present(alertViewControler, animated: true, completion: nil)
            
            
            
        }else{
        
        
        //新規登録
        FIRAuth.auth()?.createUser(withEmail: emailtextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error == nil{
                //成功
                UserDefaults.standard.set("check", forKey: "check")
                
                
                self.dismiss(animated: true, completion: nil)
                
                
            }else{
                //失敗
                let alertViewController = UIAlertController(title: "おっと!", message:error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertViewController.addAction(okAction)
                
                self.present(alertViewController, animated:true, completion:nil)
                
                
                
                
            }
            
            
        })
        
        }
    }
    
   
        
    
    @IBAction func userLogin(_ sender: Any) {

        //ログイン
        FIRAuth.auth()?.signIn(withEmail: emailtextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error == nil{
                
                
                
            }else{
                //失敗
                let alertViewController = UIAlertController(title: "おっと", message:error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertViewController.addAction(okAction)
                
                self.present(alertViewController, animated:true, completion:nil)
                
                
                
            }
            
            
        })
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
