//
//  NavigationViewModel.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 21/12/23.
//

import Foundation

class NavigationViewModel {
    var hamburgerButtonTapped: (() -> Void)?
    
    func handleHamburgerButtonTap(){
        hamburgerButtonTapped?()
    }
}
