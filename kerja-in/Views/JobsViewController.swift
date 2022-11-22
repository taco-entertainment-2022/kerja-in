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
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor(named: "Black")?.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(rect: button.bounds).cgPath
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        
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
        
        if isLoggedIn == true {
            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addButton.frame = CGRect(x: 0, y: 0, width: 31, height: 31)
            addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: addButton)
            self.navigationItem.setRightBarButtonItems([item1], animated: true)
        }

        
        //MARK: - Set Table View
        setTableView()
        setFilterView()
        
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
    }
    
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
            make.top.equalToSuperview().offset(140)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
    
    
    @objc private func didTapAdd() {
        let destinationVC = AddJobViewController()
        self.navigationController?.pushViewController(destinationVC, animated: true)
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
        
        //Remove watch from date in table
        for _ in 16...20 {
            cell.dateLabel.text?.removeLast()
        }
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
        let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")

        if isLoggedIn == true {
            nextVC.jobData = jobsArr[indexPath.row].jobName ?? "-"
            nextVC.timeData = jobsArr[indexPath.row].date ?? "-"
            nextVC.categoryData = jobsArr[indexPath.row].jobImage
            nextVC.durationData = jobsArr[indexPath.row].duration ?? "-"
            nextVC.locationData = jobsArr[indexPath.row].location ?? "-"
            nextVC.paymentData = jobsArr[indexPath.row].price ?? "-"
            nextVC.descriptionData = jobsArr[indexPath.row].description ?? "-"
            nextVC.contactData = jobsArr[indexPath.row].userContact ?? "-"
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
}
