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
        app.launchArguments = ["NoAnimations"]
        app.launchArguments = ["-AppleLanguages", "(en)", "-AppleLocale", "en_US",]
     
        

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
        if app.images["WelcomeLogoLight"].waitForExistence(timeout: 3){
            XCTAssertTrue(app.images["WelcomeLogoLight"].exists)
        }
        


           textFieldSK.tap()
           textFieldSK.typeText("Lukas")
             let arrowDown = app.buttons["arrow.down.circle"]
            XCTAssertTrue(arrowDown.exists)
           arrowDown.tap()
  
    }
    
    func test02_homeScreen_translation(){
        app.terminate()

        // ENGLISH TEST
        app.launchArguments = ["-AppleLanguages", "(en)", "-AppleLocale", "en_US",]
        app.launch()
        let topNavBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        let helloUserStaticText = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["hello, Lukas"]
            XCTAssertTrue(helloUserStaticText.exists)
        
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Plants"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["0 plants need watering"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Packing"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["No upcoming trips"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Recipes"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Not cooking today"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Shopping"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["No shopping planned "].exists)

        
     
                

        app.terminate()
        // SLOVAK TEST
            app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
            app.launch()
            let helloUserStaticTextSK = topNavBar.staticTexts["ahoj, Lukas"]
            XCTAssertTrue(helloUserStaticTextSK.exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Kvety"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["0 kvetov potrebuje poliať"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Balenie"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Žiadny planovaný výlet"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Recepty"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Nič dnes nevarím"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Nakupovanie"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Žiadny nakup"].exists)
       
        
        
       
    }
    
    
    func test03_settings_translation() {
        
    }
    func test04_changeName(){
        app.launch()

        let settings = app/*@START_MENU_TOKEN@*/.buttons["slider.vertical.3"]/*[[".otherElements[\"slider.vertical.3\"].buttons[\"slider.vertical.3\"]",".buttons[\"slider.vertical.3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(settings.exists)
        settings.tap()
        let button = app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Edit Name"].staticTexts["Edit Name"]/*[[".cells",".buttons[\"Edit Name\"].staticTexts[\"Edit Name\"]",".staticTexts[\"Edit Name\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(button.waitForExistence(timeout: 2))
        button.tap()
        let elementsQuery = app.alerts["Enter your name"].scrollViews.otherElements
        let nameTextField = elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["Name"]/*[[".cells.textFields[\"Name\"]",".textFields[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nameTextField.tap()
        nameTextField.typeText("Luky")
        elementsQuery.buttons["OK"].tap()
        let backButton = app.buttons["chevron.backward"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        XCTAssertTrue(app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["hello, Luky"].exists)
        
        settings.tap()
        button.tap()
        nameTextField.tap()
        nameTextField.typeText("Lukas")
        elementsQuery.buttons["OK"].tap()
        backButton.tap()
        XCTAssertTrue(app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["hello, Lukas"].exists)
      
        
       

    }
    
    
   


 


 
}

