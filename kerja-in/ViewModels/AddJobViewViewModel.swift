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
import Combine

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
    
    func saveData(date: String, description: String, jobName: String, location: String, price: String, userImage: String, userContact: String, userID: String, jobDuration: String, timestamp: Int) {
        
        let postID: String = String(userID) + String(timestamp)
        let docRef = database.collection("jobs").document(postID)
        
        
        docRef.setData(["date": date, "description": description, "jobName": jobName, "location": location, "price": price, "userImage": userImage, "userContact": userContact, "jobDuration": jobDuration, "userID": String(userID), "timestamp": timestamp, "userName": UserDefaults.standard.string(forKey: "myIntValue")])
    }

    

}
