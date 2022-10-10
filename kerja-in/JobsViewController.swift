//
//  ViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/09/22.
//

import UIKit

class JobsViewController: UIViewController, UISearchBarDelegate {
    
    var tableView = UITableView()
    var jobsArr = [JobModel]()
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
        
        //MARK: - Set Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        
        // Customizing navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        
        //MARK: - Set Table View
        setTableView()
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Skripsi", date: "Mon, 7 Oct 2022", location: "Online", price: "Rp 10.000", posted: "3 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Car")!, jobName: "Jasa Pengemudi Malam Hari", date: "Mon, 6 Oct 2022", location: "PIK", price: "Rp 50.000", posted: "5 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja Bulanan", date: "Tue, 5 Oct 2022", location: "Tanggerang", price: "Rp 5.000", posted: "1 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Interview Mahasiswi Teknik", date: "Tue, 8 Oct 2022", location: "Online", price: "Rp 100.000", posted: "2 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Thesis", date: "Mon, 7 Oct 2022", location: "Tanggerang", price: "Rp 150.000", posted: "1 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Car")!, jobName: "Jasa Pengemudi Siang Hari", date: "Tue, 8 Oct 2022", location: "Jakarta", price: "Rp 50.000", posted: "2 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja Mingguan", date: "Mon, 7 Oct 2022", location: "Rome", price: "Rp 100.000", posted: "5 days ago"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Pasien Praktikum", date: "Tue, 8 Oct 2022", location: "Paris", price: "Rp 200.000", posted: "3 days ago"))
        
    }
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
    }
}



//MARK: - TableView Extension
extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unable to create cell")}
        cell.userImage.image = jobsArr[indexPath.row].userImage
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
    
}
