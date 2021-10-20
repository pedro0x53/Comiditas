//
//  StepsLocalizableTest.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 15/10/21.
//

import XCTest
@testable import Comiditas

class StepsLocalizableTest: XCTestCase {

    func testModalLocalizable_AlertStopText() {
        let sut = StepsLocalizable.alertStop.text
        let expectUSD = "The timer will reset if you leave this step. Are you sure you want to continue?"
        let expectPT = "O temporizador será reiniciado se você sair desse passo. Você tem certeza que quer continuar?"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_AlertAtentionText() {
        let sut = StepsLocalizable.alertAtention.text
        let expectUSD = "Attention!"
        let expectPT = "Atenção!"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_AlertCancelText() {
        let sut = StepsLocalizable.alertContinue.text
        let expectUSD = "Continue"
        let expectPT = "Continuar"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_StepText() {
        let sut = StepsLocalizable.step.text
        let expectUSD = "Step"
        let expectPT = "Passo"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_IniciateClockAcessibilityText() {
        let sut = StepsLocalizable.iniciateClockAcessibility.text
        let expectUSD = "Start timer"
        let expectPT = "Iniciar temporizador"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_pauseClockAcessibilityText() {
        let sut = StepsLocalizable.pauseClockAcessibility.text
        let expectUSD = "Pause timer"
        let expectPT = "Pausar temporizador"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_BackStepText() {
        let sut = StepsLocalizable.backStep.text
        let expectUSD = "Previous step"
        let expectPT = "Passo anterior"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_NextStepText() {
        let sut = StepsLocalizable.nextStep.text
        let expectUSD = "Next step"
        let expectPT = "Próximo passo"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizableTableName() {
        let sut = StepsLocalizable.alertStop.tableName
        let expect = "Steps"
        XCTAssertEqual(sut, expect, "An unexpected error has occurred.")
    }

}
