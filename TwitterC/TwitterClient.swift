//
//  TwitterClient.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/27/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance =  TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "YXgrKFSNhhL2brFcPlrncmtGL", consumerSecret: "xn8rza1Fk6ejtPC4srGOOjtcebvyg36K5vkwIvAADnDYuK3u6Q")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func getHomeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userPosts = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(userPosts)
            success(tweets)
            }, failure: { ( task: NSURLSessionDataTask?, error: NSError)-> Void in
                print("ERROR")
                failure(error)
        })
    }
    
    
    
    func getUserData(success: (User)-> (), failure:(NSError)->()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDic = response as! NSDictionary
            let user = User(response: userDic)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
        
    }
    
    func likePost(id: String, success:()->(), failure: (NSError) ->()) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("liked!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })


    }
    
    
    func unlikePost(id: String, success:()->(), failure: (NSError) ->()) {
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("unliked!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
        
        
    }
    
    
    
    func retweet(id: String, success:()->(), failure: (NSError) -> ()) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("liked!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
        
        
    }
    
    
    
    func handleOpenURL(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!)-> Void in
            print("got access!")
            self.getUserData({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                   print("wtf")
                   self.loginFailure?(error)
            })
            
        }) { (error: NSError!) -> Void in
            print("error!!")
        }
        
        
    }
    
    func login(success: ()-> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"TwitterC://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("got token")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
        }) { ( error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
        
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogout , object: nil)
    }
    
    
    
    
}
