//
//  FavTableViewController.swift
//  MoviesFeed
//
//  Created by Meruyert Tastandiyeva on 2/5/21.
//

import UIKit

class FavTableViewController: UITableViewController {

    var favMovies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favMovies = UserDefaults.standard.stringArray(forKey: "Movie") ?? []
        tableView.reloadData()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favMovieCell", for: indexPath) as! FavTableViewCell
        cell.favTitleLabel.text = favMovies[indexPath.row]
        return cell
    }

}
