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
        jobsArr.append(JobModel(postId: "1", userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Skripsi", userName: "Fredo Sembi", duration: "15 menit", date: "Mon, 7 Oct 2022", location: "Online", price: "Rp 10.000", posted: "3 days ago", description: "Mencari testimoni mahasiswa yang sedang mencari Dragon Ball ketujuh dan One Piece"))
        jobsArr.append(JobModel(postId: "2", userImage: UIImage(named: "Car")!, jobName: "Jasa Pengemudi Malam Hari", userName: "Leslar Tibi", duration: "7 Hari", date: "Mon, 7 Oct 2022", location: "Jakarta Barat", price: "RP 1.200.000", posted: "5 days ago", description: "Yang kuat melek 24/7 monggo dilamar"))
        jobsArr.append(JobModel(postId: "3", userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja Bulanan", userName: "Purani Mahaan", duration: "1 Hari", date: "Tue, 8 Oct 2022", location: "Singapore", price: "Rp 2.000.000", posted: "1 days ago", description: "Bantu belanja bulanan ke Marina Bay Sands"))
        jobsArr.append(JobModel(postId: "4", userImage: UIImage(named: "People")!, jobName: "Interview Mahasiswi Teknik", userName: "Sakata Gintoki Kintama", duration: "5 menit", date: "Tue, 8 Oct 2022", location: "Online", price: "Rp 10.000", posted: "2 days ago", description: "Tugas ini ibarat mencari jarum dalam tumpukan jerami, mencari One Piece, atau unicorn. Karena sangat jarang, tolong bantu saya untuk mewawancarai mahasiswi yang berkuliah di jurusan Teknik Informatika dengan jenis kelamin perempuan."))
        jobsArr.append(JobModel(postId: "5", userImage: UIImage(named: "People")!, jobName: "Menjadi Responden Thesis", userName: "Yoko Ohno", duration: "15 menit", date: "Wed, 9 Oct 2022", location: "Surabaya", price: "Rp 5.000", posted: "1 day ago", description: "Saya ingin menulis thesis mengenai Cruel Angel Thesis dan reaksi orang - orang pada umumnya ketika mendengarnya."))
        jobsArr.append(JobModel(postId: "6", userImage: UIImage(named: "Car")!, jobName: "Jasa Mengemudi Siang Hari", userName: "Indro", duration: "8 Jam", date: "Thu, 10 Oct 2022", location: "Saranjana", price: "Rp 800.000", posted: "a few seconds ago", description: "Saya tidak hafal jalan setiap kali saya diberi alamar di kota ini. Tolong temani saya untuk membacakan peta selama perjalanan. Garansi kembali tidak dijamin."))
        jobsArr.append(JobModel(postId: "7", userImage: UIImage(named: "Cart")!, jobName: "Bantu Belanja MPASI untuk bayi umur 276 bulan", userName: "Tatang Glia", duration: "1 bulan", date: "Fri, 10 Oct 2022", location: "Tasikmalaya", price: "Rp 1.500.000", posted: "a few seconds ago", description: "Minta tolong untuk memasak harian untuk anak saya yang berusia 276 bulan. Saya sibuk."))
        jobsArr.append(JobModel(postId: "8", userImage: UIImage(named: "People")!, jobName: "Menjadi Pasien Praktikum", userName: "Ningsih Slay", duration: "1 jam", date: "Fri, 10 Oct 2022", location: "Batam", price: "20.000.000", posted: "a few seconds ago", description: "Dicari kadaver hidup untuk praktikum bedah organ dalam!"))
        
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
        navigationController?.pushViewController(DetailsViewController(), animated: true)
    }
    
}
