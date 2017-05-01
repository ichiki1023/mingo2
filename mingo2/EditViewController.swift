//
//  EditViewController.swift
//  mingo2
//
//  Created by valurate.mac on 2017/04/14.
//  Copyright © 2017年 valurate. All rights reserved.
//

import UIKit
import Firebase


class EditViewController: UIViewController,UITextViewDelegate {

    var willEditImage:UIImage = UIImage()
    
    
    @IBOutlet var myProfileImageView: UIImageView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var myProfileLabel: UILabel!
    
    @IBOutlet var commentTextView: UITextView!
    
    var usernameString:String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.image = willEditImage
        commentTextView.delegate = self
        myProfileImageView.layer.cornerRadius = 8.0
        myProfileImageView.clipsToBounds = true
        
        if UserDefaults.standard.object(forKey: "profileImage") != nil{
            
            //エンコードして取り出す
            let decodeData = UserDefaults.standard.object(forKey: "profileImage")
            
            let decodedData = NSData(base64Encoded:decodeData as! String , options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            let decodedImage = UIImage(data:decodedData! as Data)
            myProfileImageView.image = decodedImage
            
            usernameString = UserDefaults.standard.object(forKey: "userName") as! String
            
            myProfileLabel.text = usernameString
            
        }else{
            
            myProfileImageView.image = UIImage(named:"logo.png") //画像を用意する
            myProfileLabel.text = "匿名"
            
            
        }

     }
    
    
    
    @IBAction func post(_ sender: Any) {
        
        postAll()
        
    }
    
    func postAll(){
        
        let databaseRef = FIRDatabase.database().reference()
        
        //ユーザー名
        let username = myProfileLabel.text!
        
        //コメント
        let message = commentTextView.text!
        
        //投稿画像
        var data:NSData = NSData()
        if let image = imageView.image{
            data = UIImageJPEGRepresentation(image,0.1)! as NSData
        }
        let base64String = data.base64EncodedString(options:NSData.Base64EncodingOptions.lineLength64Characters) as String
        
        //profile画像
        var data2:NSData = NSData()
        if let image2 = myProfileImageView.image{
            data2 = UIImageJPEGRepresentation(image2,0.1)! as NSData
        }
        let base64String2 = data2.base64EncodedString(options:NSData.Base64EncodingOptions.lineLength64Characters) as String
        
        
        //サーバーに飛ばす箱
        let user:NSDictionary = ["username":username,"comment":message,"postImage":base64String,"profileImage":base64String2]
        
        databaseRef.child("Posts").childByAutoId().setValue(user)
        
        //戻る
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    

    

}
