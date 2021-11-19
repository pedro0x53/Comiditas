//
//  Ext+ViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 19/11/21.
//

import UIKit

// hide Keyboard
extension UIViewController {
    func hideKeyboardOnBackgroundTouched() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
