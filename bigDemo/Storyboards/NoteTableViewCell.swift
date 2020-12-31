//
//  NoteTableViewCell.swift
//  bigDemo
//
//  Created by Christian Shirichena on 12/30/20.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTopLabel: UILabel!

    
    @IBOutlet weak var cellContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellTopLabel.numberOfLines = 1
        cellContentLabel.numberOfLines = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
