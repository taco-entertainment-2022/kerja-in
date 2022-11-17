//
//  JobsPostedViewController.swift
//  kerja-in
//
//  Created by Wilbert Devin Wijaya on 08/11/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class JobsPostedViewController: UIViewController, UISearchBarDelegate {
    
    var tableView = UITableView()
    var jobsArr = [JobPostedModel]()
    lazy var searchBar: UISearchBar = UISearchBar()
    
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
        navigationItem.titleView = searchBar
        
        searchBar.compatibleSearchTextField.textColor = UIColor(named: "Black")
        searchBar.compatibleSearchTextField.backgroundColor = UIColor(named: "White")
        
        
        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("jobs").whereField("userID", isEqualTo: userUID).getDocuments { snapshot, error in
            if error != nil {
                print("ERROR FETCH")
            }
            else {
                for document in snapshot!.documents {
                    //print("\(document.data()["jobName"] as! String)")
                    let jobName = document.data()["jobName"] as? String
                    let description = document.data()["description"] as? String
                    let date = document.data()["date"] as? String
                    let location = document.data()["location"] as? String
                    let price = document.data()["price"] as? String
                    let userContact = document.data()["userContact"] as? String
                    let userImage = document.data()["userImage"] as? String
                    let duration = document.data()["jobDuration"] as? String

                    
                    self.jobsArr.append(JobPostedModel(userImage: UIImage(named: userImage ?? "Lainnya") ?? UIImage(named: "Lainnya")!, jobName: jobName ?? "-", duration: duration ?? "-", date: date ?? "-", location: location ?? "-", price: price ?? "-", description: description ?? "-", userContact: userContact ?? "-"))
                    
                        }
                    }

            self.tableView.reloadData()
        }
        
        
        //MARK: - Set Table View
        setTableView()
        
    }
    
    
    
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        tableView.register(JobPostedTableViewCell.self, forCellReuseIdentifier: "PostedCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
}

//MARK: - TableView Extension
extension JobsPostedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostedCell", for: indexPath) as? JobPostedTableViewCell else {fatalError("Unable to create cell")}
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
