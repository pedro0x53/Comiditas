//
//  OverviewInteractorSpy.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import Foundation
@testable import Comiditas

class OverviewInteractorSpy: OverviewPresenterProtocol {
    var didAskToPresentSharedContent: Bool = false
    var didAskToPresentCopiedContent: Bool = false

    func present(response: Overview.Response.Share) {
        self.didAskToPresentSharedContent = true
    }

    func present(response: Overview.Response.Copy) {
        self.didAskToPresentCopiedContent = true
    }
}
