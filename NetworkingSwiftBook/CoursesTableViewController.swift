//
//  CoursesTableViewController.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 13.09.2021.
//

import UIKit
import Alamofire

class CoursesTableViewController: UITableViewController {

    private let jsonUrlOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    private let jsonUrlTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    private let jsonUrlThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    private let jsonUrlFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    private var courses: [Course] = []

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CoursesCell

        let course = courses[indexPath.row]
        cell.configure(with: course)

        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func fetchDataV1() {
        guard let url = URL(string: jsonUrlOne) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name ?? "")
                print(course.imageUrl ?? "")
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV2() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV3() {
        guard let url = URL(string: jsonUrlThree) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            do {
                let websiteDescription = try JSONDecoder().decode(WedsiteDescription.self, from: data)
                print(websiteDescription.courses ?? [])
                print(websiteDescription.websiteName ?? "")
                print(websiteDescription.websiteDescripton ?? "")
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataV4() {
        guard let url = URL(string: jsonUrlFour) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            do {
                let websiteDescription = try JSONDecoder().decode(WedsiteDescription.self, from: data)
                print(websiteDescription.courses ?? [])
                print(websiteDescription.websiteName ?? "")
                print(websiteDescription.websiteDescripton ?? "")
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchData() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            do {
                self.courses = try JSONDecoder().decode([Course].self, from: data)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchDataAlamofire() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success(let value):
                
                self.courses = Course.getCourses(from: value)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postWithAlamofire() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData: [String:Any] = [
            "name": "Network Request",
            "link": "https://swiftbook.ru/contents/spritekit-full-game-dev/",
            "imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
            "numberOfLessons": "18",
            "numberOfTests": "10"
        ]
        
        AF.request(url, method: .post, parameters: userData).validate().responseJSON { responseData in
            
            switch responseData.result {
            case .success(let value):
                
                guard let jsonData = value as? [String:Any] else { return }
                
                let course = Course(dictCourse: jsonData)
                self.courses.append(course)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
