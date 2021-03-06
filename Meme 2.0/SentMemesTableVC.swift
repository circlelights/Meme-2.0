//
//  SentMemesTableVC.swift
//  Meme 2.0
//
//  Created by Developer2017 on 3/8/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableVC : UITableViewController {
    
    
    var memes: [Meme]!
    
    let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
}
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicationDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesCell")!as UITableViewCell
        let thismeme = applicationDelegate.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = thismeme.topString + "  " + thismeme.bottomString
        cell.imageView?.image = thismeme.memedImage

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.completeMeme = applicationDelegate.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
    
