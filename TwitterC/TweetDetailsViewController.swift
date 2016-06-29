//
//  TweetDetailsViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/28/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var tweetObj: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postText.text = (tweetObj?.text) as String!
        userFullName.text = (tweetObj?.userInfo?.name!) as String!
        print("profileURL: \(tweetObj?.userInfo?.profileURL)")
        let url = tweetObj?.userInfo?.profileURL
        userImage.setImageWithURL(url!)
        userName.text = (tweetObj?.userInfo?.screenname) as String!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateNS = tweetObj?.timestamp
        print(dateNS)
        print("dateee")
        let dateString = dateFormatter.stringFromDate(dateNS!)
        print(dateString)
        date.text = (dateString)
        

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
