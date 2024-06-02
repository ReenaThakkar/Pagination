//
//  PostsTableViewCell.swift
//  PaginationData
//
//  Created by Reena on 6/2/24.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lablTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(postData: Post) {
        lablTitle.text =  postData.title
        lblName.text = postData.body
        lblId.text = "Id = \(postData.id)"
    }
    
}
