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


 
    func testExample() {
                        

        
        let app = XCUIApplication()
        app.buttons["welcomeScreenButton"].tap()
        app.textFields["Enter your name"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["arrow.down.circle"]/*[[".buttons[\"Arrow Down Circle\"]",".buttons[\"arrow.down.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
                
    


    }
}
