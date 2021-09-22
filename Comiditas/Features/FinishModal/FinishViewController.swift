//
//  FinishViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class FinishViewController: UIViewController {
    var coordinator: FeedCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white

//        let finishView = FinishModalView()
//        view.addSubview(finishView)
    }

}
