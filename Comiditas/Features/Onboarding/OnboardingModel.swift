//
//  OnboardingModel.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//
//swiftlint:disable nesting

import Foundation
import UIKit

enum OnboardingModel {

    // MARK: Use Cases

    enum NextStep {

        struct Request {
            let steps: [OnboardingStep]
            let index: Int
        }

        struct Response {
            let nexStep: OnboardingStep
            let newIndex: Int
            let isLastStep: Bool
        }

        struct ViewModel {
            let index: Int
            let title: String
            let image: UIImage?
            var isLastStep: Bool
        }

    }

    enum End {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

}
