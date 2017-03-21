//
//  HomeFeedTableViewController.swift
//  Instagram
//
//  Created by Arnav Jain on 3/20/17.
//  Copyright © 2017 Arnav Jain. All rights reserved.
//

import UIKit
import Parse

class HomeFeedTableViewController: UITableViewController {
    
    @IBOutlet var mainTableView: UITableView!
    
    var posts: [PFObject] = []
    
    let thisRefreshControl = UIRefreshControl()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:83/255, green: 127/255 , blue: 164/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = 400
        mainTableView.rowHeight = UITableViewAutomaticDimension
        
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        query.includeKey("author")

        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.posts = posts!
                self.mainTableView.reloadData()
                query.limit = 20
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.mainTableView.reloadData()
    
        thisRefreshControl.addTarget(self, action: #selector(retrievePosts), for: .valueChanged)
        mainTableView.addSubview(thisRefreshControl)
        retrievePosts()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func retrievePosts() {
        
        let query = PFQuery(className: "Post")
        
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil {
                self.posts = posts!
                self.mainTableView.reloadData()
                query.limit = 20
            } else {
                print(error?.localizedDescription)
            }
        }
        
        thisRefreshControl.endRefreshing()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainTableView.reloadData()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "HomeFeedCell", for:indexPath) as! HomeFeedViewCell
        
        let post = posts[indexPath.row]
        print("User -- > \(post["author"])")
        cell.usernameLabel.text = post["author"] as? String
        cell.captionLabel.text = post["caption"] as? String
        
        if let postImage = post.value(forKey: "media") as? PFFile {
            postImage.getDataInBackground(block: { (imageData: Data?, error: Error?) in
                guard let data = imageData else {
                    return
                }
                cell.homeImageView.image = UIImage(data: data)
            })
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
