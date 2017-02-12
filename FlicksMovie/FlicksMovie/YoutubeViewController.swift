//
//  YoutubeViewController.swift
//  FlicksMovie
//
//  Created by Aarya BC on 2/11/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubeViewController: UIViewController, YTPlayerViewDelegate {
    
    var videoKey: String!
    @IBOutlet var youtubePlayer: YTPlayerView!
    override func viewDidLoad() {
        print(videoKey)
        youtubePlayer.delegate = self
        youtubePlayer.load(withVideoId:videoKey , playerVars:["autoplay":1])
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
