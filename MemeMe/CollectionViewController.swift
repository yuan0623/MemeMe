//
//  collectionViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 6/26/22.
//

import Foundation
import UIKit
class CollectionViewController:UICollectionViewController{
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    @IBOutlet var MeMeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MeMeCollectionView!.reloadData()
        print(memes.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0/10
        print(dimension)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.sentMemeImageView?.image = meme.memedImage

        return cell
    }
    
    
}
