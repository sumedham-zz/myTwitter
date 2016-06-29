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
    //var id: String?
    static let userDidLogout = "DidLogout"
    
    
    init(response: NSDictionary) {
        dictionary = response as? NSDictionary
        name = response["name"] as? String
        screenname = response["screen_name"] as? String
        descrip = response["description"] as? String
        //id = response["id_str"]
        let pURL = response["profile_image_url"] as? String
        if let pURL = pURL {
            print("made it")
            let thingprofileURL = NSURL(string: pURL)
            profileURL = thingprofileURL as NSURL!
            print(profileURL!)
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








