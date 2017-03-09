//
//  Meme.swift
//  Meme 1.0
//
//  Created by Developer2011 on 2/25/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topString: String
    var bottomString: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    static let TopNameKey = "TopNameKey"
    static let BottomNameKey = "BottomNameKey"
//    static let ImageNameKey = UIImage.self
    
    // MARK: Initializer
    
    // Generate a Villain from a three entry dictionary
    
    init(dictionary: [String : String]) {
        
        self.topString = dictionary[Meme.TopNameKey]!
        self.bottomString = dictionary[Meme.BottomNameKey]!
 //       self.memedImage = dictionary[Meme.ImageNameKey]!
    }
}
