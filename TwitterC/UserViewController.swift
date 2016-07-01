//
//  UserViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/29/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var nameLabel: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var tweetObj: Tweet?
    var tweetArray: [Tweet] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadTweets()
        nameLabel.setTitle(((tweetObj?.userInfo?.name!) as String!), forState: .Normal)
        print("profileURL: \(tweetObj?.userInfo?.profileURL)")
        
        let url = tweetObj?.userInfo?.profileURL
        profPic.setImageWithURL(url!)
        usernameLabel.text = "@\((tweetObj?.userInfo?.screenname) as String!)"
        numTweetsLabel.text = String((tweetObj?.userInfo?.statuses_count)!)
        followingLabel.text = String((tweetObj?.userInfo?.friends_count)!)
        followersCount.text = String((tweetObj?.userInfo?.followers_count)!)
        let urlC = tweetObj?.userInfo?.coverURL
        if let urlC = urlC {
            coverImage.setImageWithURL(urlC)
        }

    }
    
    func reloadTweets() {
        let name = (tweetObj?.userInfo?.screenname!) as String!
        print(name)
        TwitterClient.sharedInstance.getUserTimeLine(name, success: {(tweets: [Tweet]) -> () in
            self.tweetArray = tweets
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
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TweetDetailsSegue1"){
            let viewC = segue.destinationViewController as! TweetDetailsViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            let tweet = tweetArray[(indexPath!.row)]
            viewC.tweetObj = tweet
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
