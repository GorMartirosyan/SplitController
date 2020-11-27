//
//  MasterController.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class MasterController: UITableViewController {
    
    var array = [Metadata](){
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.loadJson { [weak self] articles in
            guard articles != nil else { return }
            DispatchQueue.main.async {
                self?.array = articles ?? []
            }
        }
        self.navigationItem.title = "Newsfeed"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return TableViewCell() }
        cell.setUp(with: array[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = Storyboard.instantiateViewController(identifier: "DetailController") as! DetailController
        
        detailVC.data = Metadata(category: self.array[indexPath.row].category,
                                 title: array[indexPath.row].title,
                                 body: self.array[indexPath.row].body,
                                 shareUrl: array[indexPath.row].shareUrl,
                                 coverPhotoUrl: self.array[indexPath.row].coverPhotoUrl,
                                 date: array[indexPath.row].date,
                                 gallery: self.array[indexPath.row].gallery,
                                 video: self.array[indexPath.row].video)
        
        let nav = UINavigationController(rootViewController: detailVC)
        self.splitViewController?.showDetailViewController(nav, sender: nil)
        
    }
}
