//
//  postCell.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/28/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking

class postCell: UITableViewCell {

 
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullName: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var postTime: UILabel!
    let onRetweetimage = UIImage(named: "retweetOn")!
    let offLikeimage = UIImage(named: "like")!
    let onLikeimage = UIImage(named: "likeOn")!
    let offRetweetImage = UIImage(named: "retweet")!

    
    var tweetObj: Tweet? {
        didSet {
            userTweet.text = (tweetObj?.text) as String!
            userFullName.setTitle(((tweetObj?.userInfo?.name!) as String!), forState: .Normal)
            print("profileURL: \(tweetObj?.userInfo?.profileURL)")
            let url = tweetObj?.userInfo?.profileURL!
            userImage.setImageWithURL(url!)
            userName.text = "@\((tweetObj?.userInfo?.screenname) as String!)"
            
            postTime.text = (tweetObj?.timestamp) as String!
            
            
            if tweetObj!.liked! {
                likeButton.setImage(onLikeimage, forState: .Normal)
            }
            else {
                likeButton.setImage(offLikeimage, forState: .Normal)
            }
            if(tweetObj!.retweeted!) {
                retweetButton.setImage(onRetweetimage, forState: .Normal)
            }
            else{
                retweetButton.setImage(offRetweetImage, forState: .Normal)
            }
            

        }
    }
    
    var likedPost: Bool?
    var retweeted: Bool?

    
    @IBAction func onLike(sender: AnyObject) {
        self.likedPost = (tweetObj?.liked) as Bool!
        if !(self.likedPost!) {
            performLike()
            print("HI")
            likeButton.setImage(onLikeimage, forState: .Normal)
            tweetObj?.liked = true
            likedPost = true
            
            
        }
        else {
            performUnlike()
            likeButton.setImage(offLikeimage, forState: .Normal)
            tweetObj?.liked = false
            self.likedPost = false
        }
        
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        self.retweeted = (tweetObj?.retweeted) as Bool!
        if !(self.retweeted!) {
            performRetweet()
            retweetButton.setImage(onRetweetimage, forState: .Normal)
            tweetObj?.retweeted = true
            self.retweeted = true
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
        TwitterClient.sharedInstance.retweet(id!, success: {print("finallyUnLiked")}, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    
        

        //
    }

}
