//
//  SentMemeDetailViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 7/1/22.
//

import Foundation
import UIKit

class SentMemeDetailViewController:UIViewController{
    
    var sentMeme:UIImage!
    
    @IBOutlet weak var myImageView: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myImageView.image = sentMeme
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
