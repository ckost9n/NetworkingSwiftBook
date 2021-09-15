//
//  MainCollectionViewController.swift
//  NetworkingSwiftBook
//
//  Created by Konstantin on 12.09.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example exampleTwo"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case postRequest = "Post Request"
    case ourCoursesAlamofire = "Our Courses Alamofire"
}

class MainCollectionViewController: UICollectionViewController {
    
    private let userActions = UserActions.allCases
    
    private let showImageSegue = "showImage"


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showImage" {
            let coursesVC = segue.destination as! CoursesTableViewController
            
            switch segue.identifier {
            case "exampleOne":
                coursesVC.fetchDataV1()
            case "exampleTwo":
                coursesVC.fetchDataV2()
            case "exampleThree":
                coursesVC.fetchDataV3()
            case "exampleFour":
                coursesVC.fetchDataV4()
            case "ourCourses":
                coursesVC.fetchData()
            case "ourCoursesAlamofire":
                coursesVC.fetchDataAlamofire()
            default: break
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell
    
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: self)
        case .exampleOne:
            performSegue(withIdentifier: "exampleOne", sender: self)
        case .exampleTwo:
            performSegue(withIdentifier: "exampleTwo", sender: self)
        case .exampleThree:
            performSegue(withIdentifier: "exampleThree", sender: self)
        case .exampleFour:
            performSegue(withIdentifier: "exampleFour", sender: self)
        case .ourCourses:
            performSegue(withIdentifier: "ourCourses", sender: self)
        case .postRequest:
            postRequest()
        case .ourCoursesAlamofire:
            performSegue(withIdentifier: "ourCoursesAlamofire", sender: self)
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
}

extension MainCollectionViewController {
    private func postRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = [
            "course": "Networking",
            "lesson": "GET and POST"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response, let data = data else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
