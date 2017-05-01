//
//  SettingViewController.swift
//  mingo2
//
//  Created by valurate.mac on 2017/04/14.
//  Copyright © 2017年 valurate. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet var usernameTextField: UITextField!
    
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
    }

    
    func openCamera(){
        
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    
    func openPhoto(){
        
        
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
        
    }
    
    @IBAction func changeProfile(_ sender: Any) {
        
        let alertViewControler = UIAlertController(title: "選択してください。", message: "", preferredStyle:.actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler:{
            (action:UIAlertAction!) -> Void in
            
            //処理を書く
            self.openCamera()
            
        })
        
        let photosAction = UIAlertAction(title: "アルバム", style: .default, handler:{
            (action:UIAlertAction!) -> Void in
            
            //処理を書く
            self.openPhoto()
            
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        
        alertViewControler.addAction(cameraAction)
        alertViewControler.addAction(photosAction)
        alertViewControler.addAction(cancelAction)
        
        present(alertViewControler, animated: true, completion: nil)

        
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profileImageView.contentMode = .scaleToFill
            profileImageView.image = pickedImage
            
        }
        
        //カメラ画面(アルバム画面)を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func logout(_ sender: Any) {
        
        try! FIRAuth.auth()?.signOut()
        
        UserDefaults.standard.removeObject(forKey: "check")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func done(_ sender: Any) {
        
        var data: NSData = NSData()
        if let image = profileImageView.image{
            
            
            data = UIImageJPEGRepresentation(image, 0.1)! as NSData
            
        }
        
        let userName = usernameTextField.text
        let base64String = data.base64EncodedString(options:
            NSData.Base64EncodingOptions.lineLength64Characters
            ) as String
        
        //アプリ内へ保存する
        UserDefaults.standard.set(base64String,forKey:"profileImage")
        UserDefaults.standard.set(userName,forKey:"userName")
        dismiss(animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(usernameTextField.isFirstResponder){
            
            usernameTextField.resignFirstResponder()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    

 

}
