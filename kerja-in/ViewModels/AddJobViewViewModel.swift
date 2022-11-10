//
//  AddJobViewViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/10/22.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseAuth

final class AddJobViewViewModel: ObservableObject {
    @Published var jobTitle: String?
    @Published var jobDescription: String?
    @Published var category: String?
    @Published var jobDuration: String?
    @Published var location: String?
    @Published var fee: String?
    @Published var contact: String?
    @Published var jobDate: String?
    @Published var error: String?
    
    let database = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let timestamp = Int(Date().timeIntervalSince1970)

    static let shared = AddJobViewViewModel()
    
    func validateJobForm() {
        guard let jobTitle = jobTitle, let jobDate = jobDate, let location = location, let fee = fee else {
            return error = "Semua data wajib diisi"
        }
        
        takeFormValues([jobTitle, jobDescription, category, jobDuration, location, fee, contact, jobDate])
    }
    
    func takeFormValues(_ formValues: [String?]) {
        print(formValues)
    }
    
    func saveData(date: String, description: String, jobName: String, location: String, price: String, userImage: String, userContact: String, userID: String, jobDuration: String) {
        
        let postID: String = String(userID) + String(timestamp)
        let docRef = database.collection("jobs").document(postID)
        
        
        docRef.setData(["date": date, "description": description, "jobName": jobName, "location": location, "price": price, "userImage": userImage, "userContact": userContact, "jobDuration": jobDuration, "userID": String(userID)])
    }
}
