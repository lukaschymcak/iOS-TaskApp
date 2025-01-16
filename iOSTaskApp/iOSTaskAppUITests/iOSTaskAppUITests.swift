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
        app.launch()
        
        let settings = app/*@START_MENU_TOKEN@*/.buttons["slider.vertical.3"]/*[[".otherElements[\"slider.vertical.3\"].buttons[\"slider.vertical.3\"]",".buttons[\"slider.vertical.3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(settings.exists)
        settings.tap()
       
        // English
        let collectionViewsQuery = app.collectionViews
        let settingsEN = collectionViewsQuery.staticTexts["SETTINGS"]
        XCTAssertTrue(settingsEN.exists)
        let namme = collectionViewsQuery.staticTexts["Edit Name"]
        XCTAssertTrue(namme.exists)
        let language = collectionViewsQuery.buttons["Change Language"]
    
        XCTAssertTrue(language.exists)
        let packageSettings = collectionViewsQuery.staticTexts["PACKING MODULE SETTINGS"]
        XCTAssertTrue(packageSettings.exists)
        let plantsSettings = collectionViewsQuery.staticTexts["PLANTS MODULE SETTINGS"]
        XCTAssertTrue(plantsSettings.exists)
        let notificationsPacking = collectionViewsQuery.children(matching: .cell).element(boundBy: 4).switches["Enable Notifications"]
        XCTAssertTrue(notificationsPacking.exists)
        let notificationsPlants = collectionViewsQuery.children(matching: .cell).element(boundBy: 7).switches["Enable Notifications"]
        XCTAssertTrue(notificationsPlants.exists)
        let resetPacking = collectionViewsQuery.buttons["Reset Packing Module (TESTING)"]
        XCTAssertTrue(resetPacking.exists)
        let resetPlants = collectionViewsQuery.buttons["Reset Plants Module (TESTING)"]
        XCTAssertTrue(resetPlants.exists)
     
// Slovak
        app.terminate()
        app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
        app.launch()
        settings.tap()
        let nameSK = collectionViewsQuery.staticTexts["Zmeniť meno"]
        XCTAssertTrue(nameSK.exists)
        let languageSK = collectionViewsQuery.buttons["Zmeniť jazyk"]
        XCTAssertTrue(languageSK.exists)
        let packageSettingsSK = collectionViewsQuery.staticTexts["NASTAVENIA MODULU BALENIA"]
        XCTAssertTrue(packageSettingsSK.exists)
        let plantsSettingsSK = collectionViewsQuery.staticTexts["NASTAVENIA MODULU KVETOV"]
        XCTAssertTrue(plantsSettingsSK.exists)
        let notificationsPackingSK = collectionViewsQuery.children(matching: .cell).element(boundBy: 4).switches["Povoliť notifikácie"]
        XCTAssertTrue(notificationsPackingSK.exists)
        let notificationsPlantsSK = collectionViewsQuery.children(matching: .cell).element(boundBy: 7).switches["Povoliť notifikácie"]
        XCTAssertTrue(notificationsPlantsSK.exists)
        let resetPackingSK = collectionViewsQuery.buttons["Resetni Modul Balenia (TESTING)"]
        XCTAssertTrue(resetPackingSK.exists)
        let resetPlantsSK = collectionViewsQuery.buttons["Resetni Modul Kvetov (TESTING)"]
        XCTAssertTrue(resetPlantsSK.exists)
        
        
        
        
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
    func test05_packing_module_EN(){
        
        let app = XCUIApplication()
       
     app.launch()
        
        let ttgc7swiftui32navigationstackhostingNavigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        
        
        let chevronBackwardButton = ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["chevron.backward"]/*[[".otherElements[\"Back\"]",".buttons[\"Back\"]",".buttons[\"chevron.backward\"]",".otherElements[\"chevron.backward\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
    
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = app.scrollViews.otherElements
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Packing"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["No upcoming trips"].exists)
        elementsQuery.buttons["Packing, No upcoming trips"].tap()
        app.buttons["History"].tap()
        XCTAssertTrue(app.staticTexts["History:"].exists)
        XCTAssertTrue(app.staticTexts["History is Empty"].exists)
        app.buttons["Current"].tap()
        XCTAssertTrue(app.staticTexts["My Trips:"].exists)
        XCTAssertTrue(app.staticTexts["Add a trip to see details"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Enter trip"].tap()
        app.textFields["Enter trip"].typeText("Kosice")
        app.buttons["addTripButton"].tap()
        XCTAssertTrue(app.staticTexts["Jan 16, 2025"].exists)
        XCTAssertTrue(app.staticTexts["-"].exists)
        XCTAssertTrue(app.staticTexts["Jan 16, 2025"].exists)
        XCTAssertTrue(app.staticTexts["Kosice"].exists)
        XCTAssertTrue(app.staticTexts["0%"].exists)
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Packing"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Kosice"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Today"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["0% \n packed"].exists)
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Packing"]/*[[".buttons[\"Packing, Trip, Today, 0% \\n packed\"].staticTexts[\"Packing\"]",".staticTexts[\"Packing\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
     
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["minus"]/*[[".buttons[\"Jan 16, 2025, -, Jan 16, 2025, Trip, 0%\"]",".buttons[\"Remove\"]",".buttons[\"minus\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Delete Trip ?"].scrollViews.otherElements.buttons["Yes"].tap()
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Packing"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["No upcoming trips"].exists)

                
    
        
                                
    }
    func test05_packing_module_SK(){
        
        app.terminate()
        app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
        app.launch()
        
        let ttgc7swiftui32navigationstackhostingNavigationBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        
        
        let chevronBackwardButton = ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["chevron.backward"]/*[[".otherElements[\"Back\"]",".buttons[\"Back\"]",".buttons[\"chevron.backward\"]",".otherElements[\"chevron.backward\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
    
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = app.scrollViews.otherElements
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Balenie"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Žiadny planovaný výlet"].exists)
        elementsQuery.buttons["Balenie, Žiadny planovaný výlet"].tap()
        app.buttons["Historia"].tap()
        XCTAssertTrue(app.staticTexts["História:"].exists)
        XCTAssertTrue(app.staticTexts["História je prázdna"].exists)
        app.buttons["Aktuálne"].tap()
        XCTAssertTrue(app.staticTexts["Moje Výlety:"].exists)
        XCTAssertTrue(app.staticTexts["Pridaj si výlet aby si videl viac"].exists)
        
        app/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Zadaj názov"].tap()
        app.textFields["Zadaj názov"].typeText("Kosice")
        app.buttons["addTripButton"].tap()
        XCTAssertTrue(app.staticTexts["16. 1. 2025"].exists)
        XCTAssertTrue(app.staticTexts["-"].exists)
        XCTAssertTrue(app.staticTexts["16. 1. 2025"].exists)
        XCTAssertTrue(app.staticTexts["Kosice"].exists)
        XCTAssertTrue(app.staticTexts["0%"].exists)
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Balenie"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Kosice"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Dnes"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["0% pobalený"].exists)
        elementsQuery.staticTexts["Balenie"].tap()
        elementsQuery.buttons["minus"].tap()
        app.alerts["Vymazať výlet ?"].scrollViews.otherElements.buttons["Ano"].tap()
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Balenie"].exists)
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["Žiadny planovaný výlet"].exists)
        
    
                                
    }
    
    func test06_trip_testEN(){
        app.launch()
        let navBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        
        
        let chevronBackwardButton = navBar/*@START_MENU_TOKEN@*/.buttons["chevron.backward"]/*[[".otherElements[\"Back\"]",".buttons[\"Back\"]",".buttons[\"chevron.backward\"]",".otherElements[\"chevron.backward\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
    
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Packing, No upcoming trips"].tap()
        app.buttons["Current"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Enter trip"].tap()
        app.textFields["Enter trip"].typeText("Kosice")
        app.buttons["addTripButton"].tap()
        
       // Trip English Test
        elementsQuery.staticTexts["Kosice"].tap()
       
        XCTAssertTrue(navBar.staticTexts["Kosice"].exists)
        XCTAssertTrue(app.staticTexts["Jan 16, 2025"].exists)
        XCTAssertTrue(app.staticTexts[" - "].exists)
        XCTAssertTrue(app.staticTexts["Jan 16, 2025"].exists)
        XCTAssertTrue( app.staticTexts["My Bags:"].exists)
       // Checking if bag is created
        let bagTextField = app.textFields["Bag"]
        bagTextField.tap()
        app.buttons["plus"].tap()
        app.alerts["Please enter a bag name"].scrollViews.otherElements.buttons["OK"].tap()
        bagTextField.typeText("Bag")
        app/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(elementsQuery.staticTexts["Bag"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["0/0"].exists)
        // Checking if item is created
        let itemTextField = elementsQuery.textFields["Item"]
        itemTextField.tap()
        itemTextField.typeText("Phone")
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(elementsQuery.staticTexts["Phone"].exists)
                // Checking if checkbox work
        XCTAssertTrue(elementsQuery.staticTexts["0/1"].exists)
        elementsQuery.images["square"].tap()
        XCTAssertTrue(elementsQuery.images["checkmark"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["1/1"].exists)
        // Checking if percentage works
        chevronBackwardButton.tap()
        XCTAssertTrue(app.staticTexts["100%"].exists)
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["100% \n packed"].exists)
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Packing"]/*[[".buttons[\"Packing, Trip, Today, 0% \\n packed\"].staticTexts[\"Packing\"]",".staticTexts[\"Packing\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.staticTexts["Kosice"].tap()
        
        elementsQuery.children(matching: .button).matching(identifier: "x.circle").element(boundBy: 1).tap()
        XCTAssertFalse(elementsQuery.staticTexts["Phone"].exists)
        elementsQuery.buttons["x.circle"].tap()
        app.alerts["Remove Bag ?"].scrollViews.otherElements.buttons["Confirm"].tap()
        XCTAssertFalse(elementsQuery.staticTexts["Bag"].exists)
        chevronBackwardButton.tap()
        XCTAssertTrue(app.staticTexts["0%"].exists)
        chevronBackwardButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.staticTexts["0% \n packed"].exists)
        elementsQuery.staticTexts["Packing"].tap()
        elementsQuery.buttons["minus"].tap()
        app.alerts["Delete Trip ?"].scrollViews.otherElements.buttons["Yes"].tap()
    
        
        
    }
    
    func test_07_trip_testSK() {
        let navBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        
        
        let chevronBackwardButton = navBar/*@START_MENU_TOKEN@*/.buttons["chevron.backward"]/*[[".otherElements[\"Back\"]",".buttons[\"Back\"]",".buttons[\"chevron.backward\"]",".otherElements[\"chevron.backward\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        app.launchArguments = ["-AppleLanguages", "(sk)", "-AppleLocale", "sk",]
        app.launch()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Balenie, Žiadny planovaný výlet"].tap()
        app.buttons["Aktuálne"].tap()
        app.buttons["plus"].tap()
        app.textFields["Zadaj názov"].tap()
        app.textFields["Zadaj názov"].typeText("Kosice")
        app.buttons["addTripButton"].tap()
        elementsQuery.staticTexts["Kosice"].tap()
        XCTAssertTrue( app.staticTexts["Tašky:"].exists)
        let bagTextField = app.textFields["Taška"]
        bagTextField.tap()
        bagTextField.typeText("Taška")
        app.buttons["plus"].tap()
        XCTAssertTrue(elementsQuery.staticTexts["Taška"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["0/0"].exists)
        let itemTextField = elementsQuery.textFields["Položka"]
        itemTextField.tap()
        itemTextField.typeText("Telefón")
        elementsQuery.buttons["plus"].tap()
        XCTAssertTrue(elementsQuery.staticTexts["Telefón"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["0/1"].exists)
        elementsQuery.images["square"].tap()
        XCTAssertTrue(elementsQuery.images["checkmark"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["1/1"].exists)
        elementsQuery.images["checkmark"].tap()
        chevronBackwardButton.tap()
        elementsQuery.buttons["minus"].tap()
        app.alerts["Vymazať výlet ?"].scrollViews.otherElements.buttons["Ano"].tap()
        
        
        
      
        
       
        
        
    }
    
    func test_08_add_trip_history(){
        app.launch()
        let navBar = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        let chevronBackwardButton = navBar/*@START_MENU_TOKEN@*/.buttons["chevron.backward"]/*[[".otherElements[\"Back\"]",".buttons[\"Back\"]",".buttons[\"chevron.backward\"]",".otherElements[\"chevron.backward\"]"],[[[-1,2],[-1,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Packing, No upcoming trips"].tap()
        app.buttons["Current"].tap()
        app.buttons["plus"].tap()
        app.textFields["Enter trip"].tap()
        app.textFields["Enter trip"].typeText("Kosice")
        app.buttons["addTripButton"].tap()
        elementsQuery.staticTexts["Kosice"].tap()
        let bagTextField = app.textFields["Bag"]
        bagTextField.tap()
        bagTextField.typeText("Bag")
        app/*@START_MENU_TOKEN@*/.buttons["plus"]/*[[".buttons[\"Add\"]",".buttons[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(elementsQuery.staticTexts["Bag"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["0/0"].exists)
        let itemTextField = elementsQuery.textFields["Item"]
        itemTextField.tap()
        itemTextField.typeText("Phone")
        elementsQuery.buttons["plus"].tap()
        XCTAssertTrue(elementsQuery.staticTexts["Phone"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["0/1"].exists)
        elementsQuery.images["square"].tap()
        XCTAssertTrue(elementsQuery.images["checkmark"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["1/1"].exists)
        chevronBackwardButton.tap()
        elementsQuery.buttons["checkmark"].tap()
        app.alerts["Complete Trip ?"].scrollViews.otherElements.buttons["Confirm"].tap()
        app.buttons["History"].tap()
        XCTAssertTrue(elementsQuery.staticTexts["Kosice"].exists)
        elementsQuery.staticTexts["Kosice"].tap()
        XCTAssertTrue( elementsQuery.staticTexts["Bag"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["Phone"].exists)
    }
    
   


 


 
}

