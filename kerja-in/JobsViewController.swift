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
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""

        
        //MARK: - Set Table View
        setTableView()
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Skripsi", posted: "3 days ago", userName: "Fredo Sembi", date: "Mon, 7 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Car")!, jobName: "Jasa Pengemudi Malam Hari", posted: "5 days ago", userName: "Fredo Sembi", date: "Mon, 6 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja Bulanan", posted: "1 days ago", userName: "Fredo Sembi", date: "Tue, 5 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Interview Mahasiswi Teknik", posted: "2 days ago", userName: "Fredo Sembi", date: "Tue, 12 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Thesis", posted: "1 days ago", userName: "Fredo Sembi", date: "Mon, 7 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Car")!, jobName: "Jasa Pengemudi Siang Hari", posted: "2 days ago", userName: "Fredo Sembi", date: "Mon, 7 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja Mingguan", posted: "5 days ago", userName: "Fredo Sembi", date: "Mon, 7 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        jobsArr.append(JobModel(userImage: UIImage(named: "People")!, jobName: "Menjadi Pasien Praktikum", posted: "3 days ago", userName: "Fredo Sembi", date: "Mon, 7 Oct 2022", duration: "15 Menit", location: "Online", price: "Rp 10.000"))
        
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
}



//MARK: - TableView Extension
extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JobsTableViewCell else {fatalError("Unable to create cell")}
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsViewController(), animated: true)
    }
    
}
