//
//  TableViewController.swift
//  MemeMe
//
//  Created by Yuan Gao on 6/26/22.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var PlusButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Here is the table view")
        self.TableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memes.count
        //return appDelegate.favoriteThings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedMeme")!
        let meme = self.appDelegate.memes[(indexPath as NSIndexPath).row]
        
        // Set the image
        if let topText = meme.topText{
            if let BottomText = meme.bottomText{
                cell.textLabel?.text = topText+" "+BottomText
            }
            else{
                cell.textLabel?.text = topText
            }
        }
        
        cell.imageView?.image = meme.memedImage
        
        
        return cell
        
    }
    

    @IBAction func PressPlusBotton(_ sender: Any) {
        print("plus button is pressed")
    }
    
    
    
    
}
