//
//  AddJobViewViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 30/10/22.
//

import UIKit
import Foundation
import Combine
import Foundation
import FirebaseFirestore
import FirebaseAuth

final class JobViewViewModel: ObservableObject {
    @Published var respondent: Bool?
    @Published var service: Bool?
    @Published var driver: Bool?
    @Published var other: Bool?
    @Published var online: Bool?
    @Published var offline: Bool?
    
    static let shared = JobViewViewModel()
    
    func applyFilter(respondent: Bool, service: Bool, driver: Bool, other: Bool, online: Bool, offline: Bool) {
        
    }
}
