//
//  DetailViewController.swift
//  FlicksMovie
//
//  Created by Aarya BC on 2/7/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import HCSStarRatingView

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var voteCount: HCSStarRatingView!
    @IBOutlet weak var ratingsView: UIImageView!
    @IBOutlet weak var pushTest: UIButton!
    
    var movie: NSDictionary!
    var videoKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushTest.addTarget(self, action: "buttonTapped", for: .touchUpInside)
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        let smallImagePath = "https://image.tmdb.org/t/p/w45"
        let largeImagePath = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            let smallImageUrl = NSURL(string: smallImagePath + posterPath)
            let largeImageUrl = NSURL(string: largeImagePath + posterPath)
            let smallImageRequest = NSURLRequest(url: smallImageUrl! as URL)
            let largeImageRequest = NSURLRequest(url: largeImageUrl! as URL)
            self.posterImageView.setImageWith(
                smallImageRequest as URLRequest,
                placeholderImage: nil,
                success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = smallImage;
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.posterImageView.alpha = 1.0
                    }, completion: { (sucess) -> Void in
                        self.posterImageView.setImageWith(
                            largeImageRequest as URLRequest,
                            placeholderImage: smallImage,
                            success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                self.posterImageView.image = largeImage;
                        },
                            failure: { (request, response, error) -> Void in
                        })
                    })
            },
                failure: { (request, response, error) -> Void in
            })
        }
        
        networkCallTrailer()
        let rating = movie["vote_average"] as! CGFloat
        voteCount.value = rating / 2
        let movieRating = movie["adult"] as! Bool
        if (movieRating){
            let imageName = UIImage(named: "plus18.png")
            ratingsView.image = imageName
        }
        else {
            let imageName = UIImage(named: "pg13.png")
            ratingsView.image = imageName
        }
    }
    
    func buttonTapped() {
         self.performSegue(withIdentifier: "youtubePush", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let youtubeController = segue.destination as! YoutubeViewController
        youtubeController.videoKey = videoKey
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    func networkCallTrailer()
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let movieID = movie["id"] as! Int
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)")
        let request = NSURLRequest(url: url! as URL)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request as URLRequest,
          completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(
                    with: data, options:[]) as? NSDictionary {
                    if let results = responseDictionary["results"] as? [NSDictionary] {
                        self.videoKey = results[0]["key"] as? String
                    }
                }
            }
            
        });
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
