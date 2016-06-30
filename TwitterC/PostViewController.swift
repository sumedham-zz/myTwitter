//
//  PostViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/29/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(sender: AnyObject) {
        let text = textField.text
        print(text)
        TwitterClient.sharedInstance.postStatus(text!, success: {print("finallyPosted")}, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })

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
