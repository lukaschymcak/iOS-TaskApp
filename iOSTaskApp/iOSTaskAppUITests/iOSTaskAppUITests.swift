//
//  iOSTaskAppUITests.swift
//  iOSTaskAppUITests
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import XCTest

final class iOSTaskAppUITests: XCTestCase {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {

        continueAfterFailure = false
        app = XCUIApplication()
              app.launchArguments = ["testing"]
              app.launch()
    }


 
}
