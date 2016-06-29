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

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTweet: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
    var tweetObj: Tweet? {
        didSet {
            userTweet.text = (tweetObj?.text) as String!
            userFullName.text = (tweetObj?.userInfo?.name!) as String!
            print("profileURL: \(tweetObj?.userInfo?.profileURL)")
            let url = tweetObj?.userInfo?.profileURL
            //print("NSURL: \(url)")
            userImage.setImageWithURL(url!)
            userName.text = (tweetObj?.userInfo?.screenname) as String!
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd"
            let dateNS = tweetObj?.timestamp
            print(dateNS)
            print("dateee")
            let dateString = dateFormatter.stringFromDate(dateNS!)
            print(dateString)
            postTime.text = (dateString)

        }
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
