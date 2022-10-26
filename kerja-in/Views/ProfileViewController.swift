//
//  ProfileViewController.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 30/09/22.
//

import UIKit
import FirebaseAuth
import Firebase

struct Section {
    let title: String
    let option: [SettingOption]
}

struct SettingOption {
    let title: String
    let handler: (() -> Void)
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let  tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        
        configure()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }
    
    func configure() {
        
        models.append(Section(title: "File Saya", option: [
            SettingOption(title: "Job Posted") {
                print("Tapped First Cell")
            },
            SettingOption(title: "Saved Jobs") {
                
            },
            
        ]))
        
        models.append(Section(title: "Support", option: [
            SettingOption(title: "FAQ") {
                
            },
            SettingOption(title: "Tutorial") {
                
            },
            SettingOption(title: "Ulas Aplikasi") {
                
            },
            SettingOption(title: "Report") {
                
            },
            SettingOption(title: "Mengenai Kerjaan") {
                
            },
            
        ]))
        
        models.append(Section(title: "", option: [
            SettingOption(title: "Sign Out") {
               
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                
                
                do {
                    try Auth.auth().signOut()
                    
                    let navVC = UINavigationController(rootViewController: ProfileViewController())
                    navVC.modalPresentationStyle = .fullScreen
                    //navVC.modalTransitionStyle = .coverVertical
                    self.present(navVC, animated: false) {
                        navVC.pushViewController(LoginController(), animated: false)
                    }
                    
                    
                } catch let error {
                    print("Failed to sign out with error...", error)
                }
                
            },
            
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].option[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].option[indexPath.row]
        model.handler()
    }
    

}
