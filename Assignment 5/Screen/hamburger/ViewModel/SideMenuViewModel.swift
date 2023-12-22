//
//  SideMenuViewModel.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 22/12/23.
//
import Foundation
import Alamofire
import SwiftyJSON

class SideMenuViewModel {
    var menuItems: [MenuItem] = []

    func fetchMenuItems(completion: @escaping () -> Void) {
        let apiURL = "https://mocki.io/v1/e0b251e0-00cf-46a2-95dd-c2e30c2eab53"

        AF.request(apiURL).response { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                self.parseMenuItems(json: json)
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    private func parseMenuItems(json: JSON) {
        if let jsonArray = json.array {
            menuItems = jsonArray.map { MenuItem(title: $0.stringValue) }
        }
    }
}
