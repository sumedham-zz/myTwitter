//
//  Tweet.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/27/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int?
    var favoritesCount: Int?
    var idStr: String?
    
    var userInfo: User?
    
    init(response: NSDictionary) {
        text = response["text"] as? String
        retweetCount = (response["retweet_count"] as? Int) ?? 0
        favoritesCount = (response["favorites_count"] as? Int) ?? 0
        idStr = response["id_str"] as? String
        var timestampString = response["created_at"] as? String
        
        let responseUser = response["user"] as! NSDictionary!
        userInfo = User(response: responseUser)
        print(userInfo?.profileURL)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        if let timestampString = timestampString {
            timestamp = formatter.dateFromString(timestampString)
        }
        
    }
    
    class func tweetsWithArray(dics: [NSDictionary])-> [Tweet] {
        var tweets = [Tweet]()
        for dic in dics {
            let newTweet = Tweet(response: dic)
            tweets.append(newTweet)
            
        }
        return tweets
        
    }

}
