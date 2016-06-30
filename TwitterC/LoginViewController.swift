//
//  LoginViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/27/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLoginTap(sender: AnyObject) {
        let client = TwitterClient.sharedInstance
        client.login({ () -> () in
        self.performSegueWithIdentifier("loginSegue", sender: nil)
            })
        {(failure: NSError) -> () in
            print(failure.localizedDescription)
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
