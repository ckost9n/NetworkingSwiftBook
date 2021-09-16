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
    let numberOfLessons: String?
    let numberOfTests: String?
//    let numberOfLessons: Int?
//    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case link = "link"
        case imageUrl = "imageUrl"
        case numberOfLessons = "number_of_lessons"
        case numberOfTests = "number_of_tests"
    }
    
    static func getCourses(from jsonData: Any) -> [Course] {
        guard let jsonData = jsonData as? Array<[String:Any]> else { return [] }
        return jsonData.compactMap { Course(dictCourse: $0) }
//
//        var courses: [Course] = []
//
//        for dictCourse in jsonData {
//            let course = Course(dictCourse: dictCourse)
//            courses.append(course)
//        }
//        return courses
    }
    
    init(dictCourse: [String:Any]) {
        name = dictCourse["name"] as? String
        link = dictCourse["link"] as? String
        imageUrl = dictCourse["imageUrl"] as? String
        numberOfLessons = dictCourse["numberOfLessons"] as? String
        numberOfTests = dictCourse["numberOfTests"] as? String
//        numberOfLessons = dictCourse["number_of_lessons"] as? Int
//        numberOfTests = dictCourse["number_of_tests"] as? Int
    }
}

struct WedsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescripton: String?
    let websiteName: String?
}
