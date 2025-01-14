//
//  iOSTaskAppUITests.swift
//  iOSTaskAppUITests
//
//  Created by Lukas Chymcak on 10/10/2024.
//

import XCTest

let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

func deleteMyApp() {
    XCUIApplication().terminate()

    let bundleDisplayName = "TaskApp"

    let icon = springboard.icons[bundleDisplayName]
    if icon.exists {
        icon.press(forDuration: 1)

        let buttonRemoveApp = springboard.buttons["Remove App"]
        if buttonRemoveApp.waitForExistence(timeout: 5) {
            buttonRemoveApp.tap()
        } else {
            XCTFail("Button \"Remove App\" not found")
        }

        let buttonDeleteApp = springboard.alerts.buttons["Delete App"]
        if buttonDeleteApp.waitForExistence(timeout: 5) {
            buttonDeleteApp.tap()
        }
        else {
            XCTFail("Button \"Delete App\" not found")
        }

        let buttonDelete = springboard.alerts.buttons["Delete"]
        if buttonDelete.waitForExistence(timeout: 5) {
            buttonDelete.tap()
        }
        else {
            XCTFail("Button \"Delete\" not found")
        }
    }
}



final class iOSTaskAppUITests: XCTestCase {

    var app = XCUIApplication()
   


    override func setUpWithError() throws {

        continueAfterFailure = false
        app = XCUIApplication()
        

    }
    
    override func tearDownWithError() throws {
        XCUIDevice.shared.appearance = .light
       
        app.terminate()
    
        
    }
    func test01_welcomescreen(){
        
        let app = XCUIApplication()
        app.launchArguments = ["-AppleLanguages", "(en)", "-AppleLocale", "en_US",]
        app.launch()
        let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let notificationAlertButton = springBoard.buttons["Allow"]
        if notificationAlertButton.waitForExistence(timeout: 3){
            if notificationAlertButton.exists {
                
                notificationAlertButton.tap()
                
            }
        }
        // English language tests
            XCTAssertTrue(app.staticTexts["Welcome"].exists)
            let textFieldEN = app.textFields["Enter your name"]
            XCTAssertTrue(textFieldEN.exists)
            app.terminate()
            // Slovak language tests
            app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
            app.launch()
            XCTAssertTrue(app.staticTexts["Vitaj"].exists)
            let textFieldSK = app.textFields["Zadaj svoje meno"]
            XCTAssertTrue(textFieldSK.exists)
       // UI color mode tests


            XCTAssertTrue(app.images["WelcomeLogoDark"].exists)
            XCUIDevice.shared.appearance = .dark
            XCTAssertTrue(app.images["WelcomeLogoLight"].exists)

           textFieldSK.tap()
           textFieldSK.typeText("Lukas")
             let arrowDown = app.buttons["arrow.down.circle"]
            XCTAssertTrue(arrowDown.exists)
           arrowDown.tap()
  
    }
    
    func test02_homeScreen(){
       let app = XCUIApplication()
        let topNavBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        // ENGLISH TEST
        app.launchArguments = ["-AppleLanguages", "(en)", "-AppleLocale", "en_US",]
        app.launch()
        let helloUserStaticText = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["hello, Lukas"]
            XCTAssertTrue(helloUserStaticText.exists)

        app.terminate()
        // SLOVAK TEST
            app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
            app.launch()
            let helloUserStaticTextSK = topNavBar.staticTexts["ahoj, Lukas"]
            XCTAssertTrue(helloUserStaticTextSK.exists)
       
    }
    func test03_changeName(){
        let app = XCUIApplication()
        app.launch()
        let topNavBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        let settings = app/*@START_MENU_TOKEN@*/.buttons["slider.vertical.3"]/*[[".otherElements[\"slider.vertical.3\"].buttons[\"slider.vertical.3\"]",".buttons[\"slider.vertical.3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        
        
  
        
                
                        
        
    }


 


 
}

