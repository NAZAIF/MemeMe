//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Moideen Nazaif VM on 11/05/19.
//  Copyright © 2019 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class SentMemesTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count == 0 ? showEmptyView(true) : showEmptyView(false)
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCotroller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailCotroller.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(detailCotroller, animated: true)
    }
    
    func showEmptyView(_ show: Bool) {
        if show {
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
            label.numberOfLines = 2
            label.textAlignment = .center
            label.text = "No Memes Stored!\nClick '+' to create a new Meme."
            tableView.backgroundView = nil
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
    }
    
    
   
}
