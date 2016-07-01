//
//  ProfileViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/30/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var userObj: User?
    var tweetArray: [Tweet] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.setUserData()
        setUserData()

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUserData() {
        
        TwitterClient.sharedInstance.getUserData({ (user: User) -> () in
            self.userObj = user
            self.nameLabel.text = self.userObj?.name!
            
            self.descriptionLabel.text = self.userObj?.descrip!
            print(self.userObj?.name!)
            self.usernameLabel.text = self.userObj?.screenname!
            let url = self.userObj?.profileURL!
            self.profilePic.setImageWithURL(url!)
            self.reloadTweets()
            
            }, failure: { (error: NSError) -> () in

                print(error.localizedDescription)
                
        })
        
    }
    
    func reloadTweets() {
        let name = userObj?.screenname!
        print(name)
        TwitterClient.sharedInstance.getUserTimeLine(name!, success: {(tweets: [Tweet]) -> () in
            self.tweetArray = tweets
            print(tweets)
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCell
        cell.tweetObj = tweetArray[indexPath.row]
        //print(TweetArray[indexPath.row].userInfo)
        //print("wow")
        return cell

    }


}
