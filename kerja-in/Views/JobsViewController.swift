//
//  ViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/09/22.
//

import UIKit
import FirebaseFirestore
import Firebase

class JobsViewController: UIViewController {
    
    var tableView = UITableView()
    var jobsArr = [JobModel]()
    var filteredJobs = [JobModel]()
    var isSearching = false
    
    lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.dimsBackgroundDuringPresentation = false
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.searchTextField.backgroundColor = UIColor(named: "White")
        searchBar.searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.searchBar.placeholder = "Cari Pekerjaan..."
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.isTranslucent = false
        searchBar.searchBar.delegate = self
        searchBar.searchBar.tintColor = UIColor(named: "Black")
        searchBar.searchBar.searchTextField.font = UIFont.Outfit(.light, size: 16)
        searchBar.searchBar.compatibleSearchTextField.textColor = UIColor(named: "Black")
        searchBar.searchBar.compatibleSearchTextField.backgroundColor = UIColor(named: "White")
        searchBar.automaticallyShowsCancelButton = false
        return searchBar
    }()
    
    let addButton = UIButton(type: .custom)
    
    let database = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let timestamp = Int(Date().timeIntervalSince1970)
    
    let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        self.navigationItem.title = nil
        
        
        //MARK: - Set Search Bar
        navigationItem.titleView = self.searchBar.searchBar
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(named: "White")
        
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
        
        if isLoggedIn == true {
            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addButton.frame = CGRect(x: 0, y: 0, width: 31, height: 31)
            addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: addButton)
            self.navigationItem.setRightBarButtonItems([item1], animated: true)
        }
        
        
        //MARK: - Set Table View
        setTableView()
        
        let db = Firestore.firestore()
        db.collection("jobs").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
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
                    let duration = document.data()["jobDuration"] as? String
                    
                    self.jobsArr.append(JobModel(userImage: UIImage(named: userImage ?? "Lainnya") ?? UIImage(named: "Lainnya")!,
                                                 jobName: jobName ?? "-",
                                                 duration: duration ?? "-",
                                                 date: date ?? "-",
                                                 location: location ?? "-",
                                                 price: (price != nil) ? "Rp  \(price!)" : "-",
                                                 description: description ?? "-",
                                                 userContact: userContact ?? "-"))
                }
            }
            self.tableView.reloadData()
        }
//        cancelSearch()
        tableView.keyboardDismissMode = .onDrag
        
        
    }
    
    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "DarkBlue")
        toolBar.sizeToFit()
        
        return toolBar
    }()
    
//    func cancelSearch() {
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                        target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain,
//                                         target: self, action: #selector(cancelButtonPressed))
//        
//        toolBar.isUserInteractionEnabled = true
//        toolBar.setItems([flexSpace, cancelButton], animated: true)
//        toolBar.sizeToFit()
//        searchBar.searchBar.searchTextField.resignFirstResponder()
//        searchBar.searchBar.searchTextField.inputAccessoryView = toolBar
//    }
//    
//    @objc func cancelButtonPressed() {
//        view.endEditing(true)
//    }
    
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
    
    @objc private func didTapAdd() {
        let destinationVC = AddJobViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}



//MARK: - TableView Extension
extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredJobs.count : jobsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JobsTableViewCell else {fatalError("Unable to create cell")}
        cell.userImage.image = isSearching ? filteredJobs[indexPath.row].jobImage : jobsArr[indexPath.row].jobImage
        cell.jobLabel.text = isSearching ? filteredJobs[indexPath.row].jobName : jobsArr[indexPath.row].jobName
        cell.dateLabel.text = isSearching ? filteredJobs[indexPath.row].date : jobsArr[indexPath.row].date
        
        //Remove watch from date in table
        for _ in 16...20 {
            cell.dateLabel.text?.removeLast()
        }
        cell.locationLabel.text = isSearching ? filteredJobs[indexPath.row].location : jobsArr[indexPath.row].location
        cell.priceLabel.text = isSearching ? filteredJobs[indexPath.row].price : jobsArr[indexPath.row].price
        cell.postedLabel.text = isSearching ? filteredJobs[indexPath.row].posted : jobsArr[indexPath.row].posted
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailsViewController()
        let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
        
        if isLoggedIn {
            nextVC.jobData = jobsArr[indexPath.row].jobName ?? "-"
            nextVC.timeData = jobsArr[indexPath.row].date ?? "-"
            nextVC.categoryData = jobsArr[indexPath.row].jobImage
            nextVC.durationData = jobsArr[indexPath.row].duration ?? "-"
            nextVC.locationData = jobsArr[indexPath.row].location ?? "-"
            nextVC.paymentData = jobsArr[indexPath.row].price ?? "-"
            nextVC.descriptionData = jobsArr[indexPath.row].description ?? "-"
            nextVC.contactData = jobsArr[indexPath.row].userContact ?? "-"
            if isSearching == false {
                nextVC.jobData = jobsArr[indexPath.row].jobName ?? "-"
                nextVC.timeData = jobsArr[indexPath.row].date ?? "-"
                nextVC.categoryData = jobsArr[indexPath.row].jobImage
                nextVC.durationData = jobsArr[indexPath.row].duration ?? "-"
                nextVC.locationData = jobsArr[indexPath.row].location ?? "-"
                nextVC.paymentData = jobsArr[indexPath.row].price ?? "-"
                nextVC.descriptionData = jobsArr[indexPath.row].description ?? "-"
                nextVC.contactData = jobsArr[indexPath.row].userContact ?? "-"
            } else {
                nextVC.jobData = filteredJobs[indexPath.row].jobName ?? "-"
                nextVC.timeData = filteredJobs[indexPath.row].date ?? "-"
                nextVC.categoryData = filteredJobs[indexPath.row].jobImage
                nextVC.durationData = filteredJobs[indexPath.row].duration ?? "-"
                nextVC.locationData = filteredJobs[indexPath.row].location ?? "-"
                nextVC.paymentData = filteredJobs[indexPath.row].price ?? "-"
                nextVC.descriptionData = filteredJobs[indexPath.row].description ?? "-"
                nextVC.contactData = filteredJobs[indexPath.row].userContact ?? "-"
            }
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
}

//MARK: - Search Bar Extension
extension JobsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredJobs = jobsArr.filter({ $0.jobName!.lowercased().contains(searchText.lowercased()) })
            tableView.reloadData()
        }
    }
}
