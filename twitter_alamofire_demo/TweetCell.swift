//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
//import AlamofireImage


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            userName.text = tweet.user.name
            userHandle.text = "@" + tweet.user.screenName!
            date.text = tweet.createdAtString
            
            replyLabel.text = (String(tweet.retweetCount))
            retweetLabel.text = (String(tweet.retweetCount))
            likesLabel.text = (String(describing:tweet.favoriteCount!))
            
//            userImage.af_setImage(withURL: tweet.user.image)
            
            if(tweet.favorited)! {
                likesButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }
            else  {
                likesButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
            
            if(tweet.retweeted) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            
        }
    }
    
    
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if(tweet.favorited == false) {
            tweet.favorited = true
            tweet.favoriteCount! += 1
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            
            APIManager.shared.favorite(_tweet: tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else {
                    print("Successfully favorited the Tweet \n\(String(describing: tweet?.text))")
                }
            }
        }
        else {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            
            APIManager.shared.unfavorite(_tweet: tweet) {(tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the tweet: \n\(tweet.text)")
                }
            }
        }
        refreshData()
        
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if (tweet.retweeted == false){
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            APIManager.shared.retweet(_tweet: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            APIManager.shared.unRetweet(_tweet: tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unRetweeting: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unRetweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        refreshData()
    }
    
    
    func refreshData() {
        retweetLabel.text = (String(tweet.retweetCount))
        likesLabel.text = (String(describing:tweet.favoriteCount))
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
