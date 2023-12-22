//
//  HamburgerMenuManager.swift
//  Assignment 5
//
//  Created by SENTIENTGEEKS on 22/12/23.
//

import UIKit

protocol HamburgerMenuDelegate: AnyObject {
    func hideHamburgerMenu()
}

class HamburgerMenuManager {
    weak var delegate: HamburgerMenuDelegate?

    func hideHamburgerView(inView view: UIView, leadingConstraint: NSLayoutConstraint) {
        UIView.animate(withDuration: 0.3) {
            leadingConstraint.constant = 10
            view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                leadingConstraint.constant = -280
                view.layoutIfNeeded()
            } completion: { _ in
                view.isHidden = true
            }
        }
    }
}
