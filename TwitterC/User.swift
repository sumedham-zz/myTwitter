//
//  User.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/27/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var profileURL: NSURL?
    var descrip: NSString?
    var screenname: String?
    var dictionary: NSDictionary?
    var statuses_count: Int?
    var friends_count: Int?
    var favorites_count: Int?
    var followers_count: Int?
    //var id: String?
    static let userDidLogout = "DidLogout"
    var coverURL: NSURL?
    
    
    init(response: NSDictionary) {
        dictionary = response as? NSDictionary
        name = response["name"] as? String
        screenname = response["screen_name"] as? String
        descrip = response["description"] as? String
        statuses_count = response["statuses_count"] as? Int
        friends_count = response["friends_count"] as? Int
        favorites_count = response["favourites_count"] as? Int
        followers_count = response["followers_count"] as? Int
        
        //id = response["id_str"]
        let pURL = response["profile_image_url"] as? String
        if var pURL = pURL {
            pURL = pURL.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
            let thingprofileURL = NSURL(string: pURL)
            profileURL = thingprofileURL as NSURL!
            print(profileURL!)
        }
        
        let cURL = response["profile_banner_url"] as? String
        print("COVERPIC\(cURL)")
        if var cURL = cURL {
            cURL = cURL.stringByReplacingOccurrencesOfString("_normal", withString: "_bigger")
            let thingURL = NSURL(string: cURL)
            coverURL = thingURL as NSURL!
            print("COVERPIC2\(coverURL)")
            
        }
        
    }
    
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                
                
                let defaultUser = NSUserDefaults.standardUserDefaults()
                let uData = defaultUser.objectForKey("currentUserData") as? NSData
                if let uData = uData {
                    let dictionary = try!
                        NSJSONSerialization.JSONObjectWithData(uData, options: []) as! NSDictionary
                    _currentUser  =  User(response : dictionary)
                }
            }
            return _currentUser
        }
        
    
    set(user) {
    _currentUser = user
    let defaultUser = NSUserDefaults.standardUserDefaults()
    if let user = user {
        let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
        defaultUser.setObject(data, forKey: "currentUserData")
    }
    else {
        defaultUser.setObject(nil, forKey: "currentUserData")
    }
    
    defaultUser.synchronize()
    
    }
 }

}








