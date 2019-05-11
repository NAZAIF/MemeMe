//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Moideen Nazaif VM on 11/05/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class SentMemesCollectionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

}
