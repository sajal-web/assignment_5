//
//  HamburgerViewController.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 21/12/23.
//

import UIKit

protocol HaburgerViewControllerDelegate {
    func hideHamburgerMenu()
}
class HamburgerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delegate : HaburgerViewControllerDelegate?
    var viewModel = SideMenuViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel.fetchMenuItems {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        cell.textLabel?.text = viewModel.menuItems[indexPath.row].title
        return cell
    }

}
