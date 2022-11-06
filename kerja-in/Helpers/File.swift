//
//  File.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 04/11/22.
//

import Foundation

class Singleton {
    var name = "new viewcontroller"
    static let sharedInstance = Singleton()
    
    private init() {
        
    }
}
