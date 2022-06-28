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
        cell.textLabel?.text = "hey"
        cell.imageView?.image = meme.memedImage
        
        
        return cell
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteThingCell")!
        let favoriteThingForRow = appDelegate.favoriteThings[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = favoriteThingForRow
        
        return cell
        */
        
    }
    

    @IBAction func PressPlusBotton(_ sender: Any) {
        print("plus button is pressed")
    }
    
    
    
    
}
