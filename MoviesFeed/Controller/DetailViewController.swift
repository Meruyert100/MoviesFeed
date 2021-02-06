//
//  DetailViewController.swift
//  MoviesFeed
//
//  Created by Meruyert Tastandiyeva on 2/5/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieId: Int = 0
    var movieDesctiption: String = ""
    var movieTitle: String = ""
    var favMovies: [String] = []
    
    var item = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStarIcon()
        getMovieDetails()
        
        descriptionLabel.text = movieDesctiption

        self.activityIndicator.startAnimating()
    }
    
    func setStarIcon() {
        favMovies = UserDefaults.standard.stringArray(forKey: "Movie") ?? []
        
        if favMovies.contains(movieTitle) {
            item = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFromFav))
        } else {
            item = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addToFav))
        }
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func addToFav() {
        favMovies.append(movieTitle)
        item.image = UIImage(systemName: "star.fill")
        item.action = #selector(removeFromFav)
        UserDefaults.standard.setValue(favMovies, forKey: "Movie")
    }
    
    @objc func removeFromFav() {
        let index = favMovies.firstIndex(of: movieTitle)
        favMovies.remove(at: index!)
        item.image = UIImage(systemName: "star")
        item.action = #selector(addToFav)
        UserDefaults.standard.setValue(favMovies, forKey: "Movie")
    }
    
    func getMovieDetails() {
        
        let api_token = "6c78da2cf41529284dc65d510d302bca"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(self.movieId)/videos?api_key=\(api_token)")
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["cache-control": "no-cache"]
        
        let session = URLSession.shared
        session.dataTask(with: request) {
            rawdata, response, error in
            
            if let error = error {
                print(#function, "error", error.localizedDescription)
                return
            }
            
            guard let data = rawdata, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print(#function, "error", "\(String(describing: rawdata))")
                return
            }
            
            guard let trailersJSON = json["results"] as? [[String: Any]], let key = trailersJSON[0]["key"] as? String else {
                return
            }
            
            DispatchQueue.main.async() {
                self.playVideo(key)
                self.activityIndicator.stopAnimating()
            }

            
        }.resume()

        
    }
    
    func playVideo(_ key: String) {
        let myURL = URL(string: "https://www.youtube.com/embed/\(key)?playsinLine=1?autiplay=1")
        let youtubeRequest = URLRequest(url: myURL!)
        
        self.webView?.load(youtubeRequest)
    }

}
