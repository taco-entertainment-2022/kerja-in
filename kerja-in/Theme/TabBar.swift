//
//  TabBarViewController.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 30/09/22.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        tabBar.tintColor = UIColor(named: "DarkBlue")
        tabBar.isTranslucent = false
        setupVCs()

    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: JobsViewController(), title: NSLocalizedString("Jobs", comment: ""), image: UIImage(systemName: "briefcase.fill")!),
            createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person.fill")!)
        ]
    }
    
    
}
