//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Hiren Patel on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var numTweets: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var profileTagLine: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.af_setImage(withURL: (User.current?.image)!)
        userName.text = User.current?.name
        userHandle.text = User.current?.screenName
        numTweets.text = String(describing: User.current!.tweets!)
        numFollowers.text = String(describing: User.current!.followers!)
        numFollowing.text = String(describing: User.current!.following!)
        profileTagline.text = User.current?.tagline

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
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
