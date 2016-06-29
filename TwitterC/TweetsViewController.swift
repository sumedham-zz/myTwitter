//
//  TweetsViewController.swift
//  TwitterC
//
//  Created by Sumedha Mehta on 6/27/16.
//  Copyright © 2016 Sumedha Mehta. All rights reserved.
//

import UIKit

class TweetsViewController: ViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var TweetArray: [Tweet] = []
    var queryLimit = 3
    var queryAdd = 2
    var isMoreDataLoading = false
    //var loadingMoreView: InfiniteScrollActivityView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //infinite scroll
        //let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        //loadingMoreView = InfiniteScrollActivityView(frame: frame)
        //loadingMoreView!.hidden = true
        //tableView.addSubview(loadingMoreView!)
        
        //var insets = tableView.contentInset;
        //insets.bottom += InfiniteScrollActivityView.defaultHeight;
        //tableView.contentInset = insets
        
        //getting data
        
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        TwitterClient.sharedInstance.getHomeTimeline({ (tweets: [Tweet]) -> () in
            self.TweetArray = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        TwitterClient.sharedInstance.getUserData({ (user: User) -> () in
            print(user.name)
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        

        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.getHomeTimeline({ (tweets: [Tweet]) -> () in
            self.TweetArray = tweets
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        refreshControl.endRefreshing()

        
    }
    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
    }

    @IBAction func logoutOnTap(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (TweetArray.count);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCell
        cell.tweetObj = TweetArray[indexPath.row]
        print(TweetArray[indexPath.row].userInfo)
        print("wow")
        return cell
   
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewC = segue.destinationViewController as! TweetDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let tweet = TweetArray[(indexPath!.row)]
        viewC.tweetObj = tweet
 
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
