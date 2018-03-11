//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hiren Patel on 3/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
//import AlamofireImage


protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweettext: UITextView!
    
    var tweet: Tweet!
    
    var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var tweetCountdown: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweettext.delegate = self
        tweettext.isEditable = true
        self.tweettext.layer.borderWidth = 3.0
        self.tweettext.layer.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 141
        let userText = NSString(string: tweettext.text).replacingCharacters(in: range, with: text)
        tweetCountdown.text = String(charLimit - userText.utf8CString.count)
        
        return userText.utf8CString.count < charLimit
    }
    
    
    @IBAction func didTapTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: "This is my tweet 😀") { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
