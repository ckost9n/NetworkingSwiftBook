//
//  Course.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 13.09.2021.
//

struct Course: Decodable {
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WedsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescripton: String?
    let websiteName: String?
}
