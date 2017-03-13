//
//  MemeDetailViewController.swift
//  Meme 2.0
//
//  Created by Developer2017 on 3/8/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var completeMeme: Meme!
    
    let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = self.completeMeme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
