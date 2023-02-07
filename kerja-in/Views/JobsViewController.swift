//
//  ViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/09/22.
//

import UIKit
import FirebaseFirestore
import Firebase
import Foundation

class JobsViewController: UIViewController {
    
    var tableView = UITableView()
    var jobsArr = [JobModel]()
    var filteredJobs = [JobModel]()
    var isSearching = false
    let db = Firestore.firestore()
    
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
    private let viewConstraints = ViewConstraints()
    
    private lazy var filterScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 500)
        
        return scroll
    }()
    
    private lazy var filterContentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    private lazy var filterViewButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.regular, size: 16)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "White")
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = UIColor(named: "Black")

        button.layer.cornerRadius = viewConstraints.cornerRadius
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor(named: "Black")?.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 6
        button.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        return button
    }()
    
    private lazy var filterByCategoryButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Berdasarkan Kategori", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.regular, size: 16)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "White")

        button.layer.cornerRadius = viewConstraints.cornerRadius
        button.layer.shadowColor = UIColor.green.cgColor//UIColor(named: "DetailsGray")?.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        
        return button
    }()
    
    private lazy var filterByLocationBUtton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Berdasarkan Lokasi", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.regular, size: 16)
        button.setTitleColor(UIColor(named: "Black"), for: .normal)
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "White")

        button.layer.cornerRadius = viewConstraints.cornerRadius
        button.layer.shadowColor = UIColor.green.cgColor//UIColor(named: "DetailsGray")?.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        self.navigationItem.title = nil
        
        loadUserName()
        
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
                    let userName = document.data()["userName"] as? String
                    
                    let timestampInt = document.data()["timestamp"] as? Int
                    let posted = PostedLabelSingleton.sharedInstance.timestampToString(timestampInt: timestampInt!)
                    
                    self.jobsArr.append(JobModel(userImage: UIImage(named: userImage ?? "Lainnya") ?? UIImage(named: "Lainnya")!,
                                                 jobName: jobName ?? "-",
                                                 userName: userName ?? "-",
                                                 duration: duration ?? "-",
                                                 date: date ?? "-",
                                                 location: location ?? "-",
                                                 price: (price != nil) ? "Rp  \(price!)" : "-",
                                                 posted: posted,
                                                 description: description ?? "-",
                                                 userContact: userContact ?? "-"))
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.keyboardDismissMode = .onDrag
    }
    
    @objc func reloadData(_ notification: Notification) {
        let db = Firestore.firestore()
        db.collection("jobs").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if error != nil {
                print("Error Fetch")
            } else {
                self.jobsArr.removeAll()
                for document in snapshot!.documents {
                    let jobName = document.data()["jobName"] as? String
                    let description = document.data()["description"] as? String
                    let date = document.data()["date"] as? String
                    let location = document.data()["location"] as? String
                    let price = document.data()["price"] as? String
                    let userContact = document.data()["userContact"] as? String
                    let userImage = document.data()["userImage"] as? String
                    let duration = document.data()["jobDuration"] as? String
                    let userName = document.data()["userName"] as? String
                    
                    let timestampInt = document.data()["timestamp"] as? Int
                    let posted = PostedLabelSingleton.sharedInstance.timestampToString(timestampInt: timestampInt!)
                    
                    self.jobsArr.append(JobModel(userImage: UIImage(named: userImage ?? "Lainnya") ?? UIImage(named: "Lainnya")!,
                                                 jobName: jobName ?? "-",
                                                 userName: userName ?? "-",
                                                 duration: duration ?? "-",
                                                 date: date ?? "-",
                                                 location: location ?? "-",
                                                 price: (price != nil) ? "Rp  \(price!)" : "-",
                                                 posted: posted,
                                                 description: description ?? "-",
                                                 userContact: userContact ?? "-"))
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Observer of  NotificationCenter for data reload trigger
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(reloadData(_:)),
                                       name: NSNotification.Name ("com.reload.data.success"),
                                       object: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    
    func loadUserName() {

        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("user").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("ERROR FETCH")
            }
            else {
                let userName = snapshot?.get("firstname") as? String
                
                let defaults = UserDefaults.standard
                defaults.set(userName, forKey: "myIntValue")
                defaults.synchronize()
            }
        }
    }
    
    
    //MARK: - Testing
    private func setFilterView() {
        view.addSubview(filterViewButton)
        filterViewButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(26)
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
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func didTapFilter() {
        let filterVC = FilterViewController()
        if #available(iOS 15.0, *) {
            if let sheet = filterVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            
            present(filterVC, animated: true)
        } else {
            present(filterVC, animated: true)
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
            nextVC.daysData = jobsArr[indexPath.row].userName ?? "-"
            if isSearching == false {
                nextVC.jobData = jobsArr[indexPath.row].jobName ?? "-"
                nextVC.timeData = jobsArr[indexPath.row].date ?? "-"
                nextVC.categoryData = jobsArr[indexPath.row].jobImage
                nextVC.durationData = jobsArr[indexPath.row].duration ?? "-"
                nextVC.locationData = jobsArr[indexPath.row].location ?? "-"
                nextVC.paymentData = jobsArr[indexPath.row].price ?? "-"
                nextVC.descriptionData = jobsArr[indexPath.row].description ?? "-"
                nextVC.contactData = jobsArr[indexPath.row].userContact ?? "-"
                nextVC.daysData = jobsArr[indexPath.row].userName ?? "-"
            } else {
                nextVC.jobData = filteredJobs[indexPath.row].jobName ?? "-"
                nextVC.timeData = filteredJobs[indexPath.row].date ?? "-"
                nextVC.categoryData = filteredJobs[indexPath.row].jobImage
                nextVC.durationData = filteredJobs[indexPath.row].duration ?? "-"
                nextVC.locationData = filteredJobs[indexPath.row].location ?? "-"
                nextVC.paymentData = filteredJobs[indexPath.row].price ?? "-"
                nextVC.descriptionData = filteredJobs[indexPath.row].description ?? "-"
                nextVC.contactData = filteredJobs[indexPath.row].userContact ?? "-"
                nextVC.daysData = jobsArr[indexPath.row].userName ?? "-"
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
