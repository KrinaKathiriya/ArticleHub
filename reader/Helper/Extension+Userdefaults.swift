//
//  UserdefaultsExtension.swift
//  reader
//
//  Created by Krina on 10/11/24.
//

import UIKit

extension UserDefaults {
    
    class var likedArticles: [String]{
        get{
            return UserDefaults.standard.array(forKey: "likedArticles") as? [String] ?? []
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "likedArticles")
        }
    }
}
