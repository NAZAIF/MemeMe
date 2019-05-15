//
//  TabBarViewController.swift
//  MemeMe
//
//  Created by user on 15/05/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addMeme(_ sender: Any) {
        let memeEditor = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        navigationController?.pushViewController(memeEditor, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
