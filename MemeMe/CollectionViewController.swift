//
//  collectionViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 6/26/22.
//

import Foundation
import UIKit
class CollectionViewController:UICollectionViewController{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var MeMeCollectionView: UICollectionView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MeMeCollectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        
        cell.sentMemeImageView?.image = meme.memedImage

        return cell
    }
    
    
}
