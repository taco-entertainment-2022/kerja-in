//
//  AddJobViewViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/10/22.
//

import UIKit
import Foundation

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

    
}
