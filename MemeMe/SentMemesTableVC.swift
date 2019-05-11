//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Moideen Nazaif VM on 11/05/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class SentMemesTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"

        return cell
    }
    

    
    
   
}
