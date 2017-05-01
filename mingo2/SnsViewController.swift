//
//  SnsViewController.swift
//  mingo2
//
//  Created by valurate.mac on 2017/04/14.
//  Copyright © 2017年 valurate. All rights reserved.
//

import UIKit
import Social


class SnsViewController: UIViewController {

    //投稿されている画像
    var detailImage = UIImage()
    
    //プロフィール画像
    var detailProfileImage = UIImage()
    
    var detailUserName = String()
    
    var myComposeview:SLComposeViewController!
    
    
    @IBOutlet var profileImageView: UIImageView!
    

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImageView.image = detailProfileImage
        label.text = detailUserName
        imageView.image = detailImage
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        
    }
    
    
    @IBAction func shareTwitter(_ sender: Any) {
        
        myComposeview =  SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        //投稿するテキスト
        
        let string = "#mingo" + " photo by " + label.text!
        myComposeview.setInitialText(string)
        
        myComposeview.add(imageView.image)
        
        //表示する
        self.present(myComposeview, animated: true, completion: nil)
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    

}
