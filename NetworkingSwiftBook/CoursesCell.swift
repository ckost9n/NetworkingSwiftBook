//
//  CoursesCell.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 12.09.2021.
//

import UIKit

class CoursesCell: UITableViewCell {
    
    @IBOutlet var courseImage: ImageView!
    
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? "0")"
        numberOfTests.text = "Number of tests: \(course.numberOfTests ?? "0")"
        courseImage.fetchImage(with: course.imageUrl)
        
//        DispatchQueue.global().async {
//            guard let imageUrl = URL(string: course.imageUrl!) else { return }
//            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
//
//            DispatchQueue.main.async {
//                self.courseImage.image = UIImage(data: imageData)
//            }
//        }
        
    }

}
