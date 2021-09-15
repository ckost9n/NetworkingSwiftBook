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
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case link = "link"
        case imageUrl = "imageUrl"
        case numberOfLessons = "number_of_lessons"
        case numberOfTests = "number_of_tests"
    }
}

struct WedsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescripton: String?
    let websiteName: String?
}
