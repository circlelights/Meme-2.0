//
//  SentMemesCollectionViewController.swift
//  Meme 2.0
//
//  Created by Developer2017 on 3/8/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

import UIKit

class SentMemesCollectionViewController : UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
    }
    
    
    
    
}
