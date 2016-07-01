//
//  TweetDetailsViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/28/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userFullName: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var likedPost: Bool?
    var retweeted: Bool?
    let onRetweetimage: UIImage = UIImage(named: "retweetOn")!
    let offLikeimage: UIImage = UIImage(named: "like")!
    let onLikeimage: UIImage = UIImage(named: "likeOn")!
    var tweetObj: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFullName.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        postText.text = (tweetObj?.text) as String!
        userFullName.setTitle(((tweetObj?.userInfo?.name!) as String!), forState: .Normal)
        print("profileURL: \(tweetObj?.userInfo?.profileURL)")
        let url = tweetObj?.userInfo?.profileURL
        userImage.setImageWithURL(url!)
        userName.text = "@\((tweetObj?.userInfo?.screenname) as String!)"
        
        favoriteCount.text = String(tweetObj?.favoritesCount! as Int!)
        print(favoriteCount.text)
        retweetCount.text = String(tweetObj?.retweetCount! as Int!)
        date.text = (tweetObj?.timestamp) as String!

        if(tweetObj!.liked!) {
            likeButton.setImage(onLikeimage, forState: .Normal)
        }
        
        else {
            likeButton.setImage(offLikeimage, forState: .Normal)
        }
        if(tweetObj!.retweeted!) {
            retweetButton.setImage(onRetweetimage, forState: .Normal)
        }

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likePost(sender: AnyObject) {
        self.likedPost = (tweetObj?.liked) as Bool!
        if !(self.likedPost!) {
            performLike()
            print("HI")
            likeButton.setImage(onLikeimage, forState: .Normal)
            tweetObj?.liked = true
            likedPost = true
            favoriteCount.text = String(Int(favoriteCount.text!)!+1)
            
        }
        else {
            performUnlike()
            likeButton.setImage(offLikeimage, forState: .Normal)
            tweetObj?.liked = false
            self.likedPost = false
            favoriteCount.text = String(Int(favoriteCount.text!)!-1)
        }

    }
  
    @IBAction func retweetButton(sender: AnyObject) {
        self.retweeted = (tweetObj?.retweeted) as Bool!
        if !(self.retweeted!) {
            performRetweet()
            retweetButton.setImage(onRetweetimage, forState: .Normal)
            tweetObj?.retweeted = true
            
            self.retweeted = true
            retweetCount.text = String(Int(retweetCount.text!)!+1)
        }

    }
    
    
    func performLike() {
        let id = tweetObj?.idStr
        print(id!)
        TwitterClient.sharedInstance.likePost(id!, success: {print("finallyLiked")}, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    
    func performUnlike() {
        let id = tweetObj?.idStr
        print(id!)
        TwitterClient.sharedInstance.unlikePost(id!, success: {print("finallyUnLiked")}, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
        
        
    }
    
    func performRetweet() {
        let id = tweetObj?.idStr
        TwitterClient.sharedInstance.retweet(id!, success: {print("retweetYO")}, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsToUser") {
            let viewC = segue.destinationViewController as! UserViewController
            viewC.tweetObj = self.tweetObj
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
