//
//  StepsInteractor.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsBusinessLogic {

}

class StepsInteractor: StepsBusinessLogic {
    var presenter: StepsPresentationLogic?
    var worker: StepsWorker = StepsWorker()
}
