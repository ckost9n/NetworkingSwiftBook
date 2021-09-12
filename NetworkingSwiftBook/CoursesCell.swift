//
//  CoursesCell.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 12.09.2021.
//

import UIKit

class CoursesCell: UITableViewCell {
    
    @IBOutlet var courseImage: UIImageView!
    
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
