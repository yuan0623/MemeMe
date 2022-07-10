//
//  collectionViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 6/26/22.
//

import Foundation
import UIKit
class CollectionViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{

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
        
        self.MeMeCollectionView.delegate = self
        self.MeMeCollectionView.dataSource = self
        //let space:CGFloat = 3.0
        //let dimension = (view.frame.size.width - (2 * space)) / 3.0
        //flowLayout.minimumInteritemSpacing = space
        //flowLayout.minimumLineSpacing = space
        //flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.sentMeme = memes[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0
            return CGSize(width: dimension, height: dimension)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      if collectionView.numberOfItems(inSection: section) == 1 {

           let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)

      }

      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
    

    
    
}


