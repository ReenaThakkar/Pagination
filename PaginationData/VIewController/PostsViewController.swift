//
//  PostsViewController.swift
//  PaginationData
//
//  Created by Reena on 6/2/24.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var currentPage = 1
    var isLoading = false
    var activityIndicator: UIActivityIndicatorView!
    var footerView: UIView?
    var computationCache: [Int: String] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostsTableViewCell", bundle: nil), forCellReuseIdentifier: "PostsTableViewCell")
        // Set up the footer view
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        activityIndicator = UIActivityIndicatorView(style: .medium)
        if let footerView = footerView, let activityIndicator = activityIndicator {
            activityIndicator.center = footerView.center
            footerView.addSubview(activityIndicator)
            tableView.tableFooterView = footerView
        }

        fetchPosts(page: currentPage)
    }
    
    func fetchPosts(page: Int) {
            isLoading = true
            activityIndicator?.startAnimating()
            APIService.shared.fetchPosts(page: page) { [weak self] (posts, error) in
                guard let self = self else { return }
                self.isLoading = false
                self.activityIndicator?.stopAnimating()
                if let posts = posts {
                    self.posts.append(contentsOf: posts)
                    self.tableView.reloadData()
                }
            }
        }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as? PostsTableViewCell else {
                  fatalError("The dequeued cell is not an instance of PostsTableViewCell.")
        }
              
        cell.configureCell(postData: posts[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.post = post
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail",
           let detailVC = segue.destination as? DetailViewController,
           let post = sender as? Post {
            detailVC.post = post
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offsetY = scrollView.contentOffset.y
           let contentHeight = scrollView.contentSize.height
           
           if offsetY > contentHeight - scrollView.frame.height {
               if !isLoading {
                   currentPage += 1
                   fetchPosts(page: currentPage)
               }
           }
       }
}

extension PostsViewController {

    func performHeavyComputation(on post: Post) -> String {
        if let cachedValue = computationCache[post.id] {
            return cachedValue
        }
        let startTime = Date()
        // Simulate heavy computation
        for _ in 0..<1000000 { _ = UUID().uuidString }
        let endTime = Date()
        let timeInterval = endTime.timeIntervalSince(startTime)
        print("Heavy computation took \(timeInterval) seconds")
        let computedValue = "Computed Value"
        computationCache[post.id] = computedValue
        return computedValue
    }
}
