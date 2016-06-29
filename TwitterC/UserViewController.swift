//
//  UserViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/29/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import AFNetworking

class UserViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var nameLabel: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    var tweetObj: Tweet?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        nameLabel.setTitle(((tweetObj?.userInfo?.name!) as String!), forState: .Normal)
        print("profileURL: \(tweetObj?.userInfo?.profileURL)")
        
        let url = tweetObj?.userInfo?.profileURL
        profPic.setImageWithURL(url!)
        usernameLabel.text = (tweetObj?.userInfo?.screenname) as String!
        
        numTweetsLabel.text = String((tweetObj?.userInfo?.statuses_count)!)
        followingLabel.text = String((tweetObj?.userInfo?.friends_count)!)
        followersCount.text = String((tweetObj?.userInfo?.followers_count)!)
        let urlC = tweetObj?.userInfo?.coverURL
        if let urlC = urlC {
            coverImage.setImageWithURL(urlC)
        }
        
        
        
        
        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "dd"
//        let dateNS = tweetObj?.timestamp
//        print(dateNS)
//        print("dateee")
//        let dateString = dateFormatter.stringFromDate(dateNS!)
//        print(dateString)
//        date.text = (dateString)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
