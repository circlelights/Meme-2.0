//
//  SentMemesTableVC.swift
//  Meme 2.0
//
//  Created by Developer2017 on 3/8/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableLayout: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
}
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesCell")!
        let thismeme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
//        cell.textLabel?.text = memes.name
//        cell.imageView?.image = UIImage(named: memes.imageName)
//        
//        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
    