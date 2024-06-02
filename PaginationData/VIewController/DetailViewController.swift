//
//  ViewController.swift
//  PaginationData
//
//  Created by Reena on 6/1/24.
//

import UIKit

class DetailViewController: UIViewController {
    var post: Post?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            titleLabel.text = post.title
            bodyLabel.text = post.body
        }
    }
}
