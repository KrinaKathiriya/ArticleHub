//
//  UIImageViewX.swift
//  reader
//
//  Created by Krina on 11/11/24.
//

import UIKit

extension UIViewController {
    
    func setupNavigationBar() {
        guard let bar = self.navigationController?.navigationBar else {
            return
        }

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        // Title and Large Title customizations
        let titleFont = UIFont(name: "Roboto-Black", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let largeTitleFont = UIFont(name: "Roboto-Black", size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .bold)
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: titleFont
        ]
        
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: largeTitleFont
        ]
        
        bar.standardAppearance = navBarAppearance
        bar.scrollEdgeAppearance = navBarAppearance
    }
}

