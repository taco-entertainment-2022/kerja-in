//
//  ViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/09/22.
//

import UIKit
import FirebaseFirestore
import Firebase

class JobsViewController: UIViewController, UISearchBarDelegate {
    
    var tableView = UITableView()
    var jobsArr = [JobModel]()
    lazy var searchBar: UISearchBar = UISearchBar()
    let addButton = UIButton(type: .custom)
    
    let database = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let timestamp = Int(Date().timeIntervalSince1970)
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        self.navigationItem.title = nil
        
        
        //MARK: - Set Search Bar
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Cari Pekerjaan..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.tintColor = UIColor(named: "Black")
        searchBar.searchTextField.font = UIFont.Outfit(.light, size: 16)
        navigationItem.titleView = searchBar
        
        searchBar.compatibleSearchTextField.textColor = UIColor(named: "Black")
        searchBar.compatibleSearchTextField.backgroundColor = UIColor(named: "White")
        
        //MARK: - Set Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        
        // Customizing navigation bar
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.frame = CGRect(x: 0, y: 0, width: 31, height: 31)
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: addButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        //MARK: - Set Table View
        setTableView()
        
        let db = Firestore.firestore()
        db.collection("jobs").getDocuments { snapshot, error in
            if error != nil {
                print("Error Fetch")
            } else {
                for document in snapshot!.documents {
                    let jobName = document.data()["jobName"] as? String
                    let description = document.data()["description"] as? String
                    let date = document.data()["date"] as? String
                    let location = document.data()["location"] as? String
                    let price = document.data()["price"] as? String
                    let userContact = document.data()["userContact"] as? String
                    let userImage = document.data()["userImage"] as? String
                    
                    self.jobsArr.append(JobModel(userImage: UIImage(named: userImage ?? "Lainnya") ?? UIImage(named: "Lainnya")!, jobName: jobName ?? "-", date: date ?? "-", location: location ?? "-", price: price ?? "-", description: description ?? "-", userContact: userContact ?? "-"))
                }
            }
            self.tableView.reloadData()
        }
    }

    
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        tableView.register(JobsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
    
    @objc private func didTapAdd() {
        print("Add")
        let rootVC = AddJobViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}



//MARK: - TableView Extension
extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JobsTableViewCell else {fatalError("Unable to create cell")}
        cell.userImage.image = jobsArr[indexPath.row].jobImage
        cell.jobLabel.text = jobsArr[indexPath.row].jobName
        cell.dateLabel.text = jobsArr[indexPath.row].date
        cell.locationLabel.text = jobsArr[indexPath.row].location
        cell.priceLabel.text = jobsArr[indexPath.row].price
        cell.postedLabel.text = jobsArr[indexPath.row].posted
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailsViewController()
        nextVC.jobData = jobsArr[indexPath.row].jobName ?? "-"
        nextVC.timeData = jobsArr[indexPath.row].date ?? "-"
        nextVC.categoryData = jobsArr[indexPath.row].jobImage
        nextVC.durationData = jobsArr[indexPath.row].duration ?? "-"
        nextVC.locationData = jobsArr[indexPath.row].location ?? "-"
        nextVC.paymentData = jobsArr[indexPath.row].price ?? "-"
        nextVC.descriptionData = jobsArr[indexPath.row].description ?? "-"
        nextVC.contactData = jobsArr[indexPath.row].userContact ?? "-"
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
