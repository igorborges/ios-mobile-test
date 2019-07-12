//
//  StepDefinition.swift
//  ShoppingAppUITests
//
//  Created by Igor Borges Resende on 11/07/19.
//  Copyright © 2019 Shyam Pindoria. All rights reserved.
//

import Foundation
import XCTest
import Cucumberish

public class CucumberishInitializer: NSObject {
   @objc public class func CucumberishSwiftInit()
    {
        //Using XCUIApplication only available in XCUI test targets not the normal Unit test targets.
//        var application : XCUIApplication!
        let app = XCUIApplication()
        //A closure that will be executed only before executing any of your features
        beforeStart { () -> Void in
            //Any global initialization can go here

        }
        Then("^I (?:will )?assert that the (text|id) \"([^\"]*)\" (?:is|has the text) \"?([^\"]*)\"?$"){ (args, userInfo) -> Void in
            let typeOfField = (args?[0])!
            let textValueOrId = (args?[1])!
            let visibleOrIdValue = (args?[2])!
            let shouldBeVisible = visibleOrIdValue.elementsEqual("visible")
            
            switch(typeOfField){
            case "id":
                XCTAssertEqual(app.staticTexts[textValueOrId].label, visibleOrIdValue)
            case "text":
                if(shouldBeVisible){
                    XCTAssert(app.staticTexts[textValueOrId].exists)
                }
            default:
                print("Scenario not mapped")
                XCTAssert(false)
            }
            
        }

        Given("that the app is opened") { (args, userInfo) -> Void in
            XCUIApplication().launch()
        }
        
        Then("the app will be closed") { (args, userInfo) -> Void in
            
        }
        
        When("^I click on (text|button) \"([^\"]*)\"$"){ (args, userInfo) -> Void in
            let typeOfField = (args?[0])!
            let textOrId = (args?[1])!
            switch(typeOfField){
            case "text":
                app.staticTexts[textOrId].tap()
            case "button":
                app.buttons[textOrId].tap()
            default:
                print("Scenario not mapped")
                XCTAssert(false)
            }
        }
        
        When("^I swipe (left|right) on the text \"([^\"]*)\"$"){ (args, userInfo) -> Void in
            let direction = (args?[0])!
            let text = (args?[1])!
            if(direction.elementsEqual("left")){
                app.staticTexts[text].swipeLeft()
            }
            else {
                app.staticTexts[text].swipeRight()
            }
        }
        
        When("I fill in the field \"([^\\\"]*)\" with the text \"([^\\\"]*)\"$") { (args, userInfo) -> Void in
            let field = (args?[0])!
            let text = (args?[1])!
            
            fillInField(field: field, text: text)
        }
        
        When("I choose the value \"([^\\\"]*)\" in the (picker wheel)$") { (args, userInfo) -> Void in
        let text = (args?[0])!
        app.pickerWheels.element.adjust(toPickerWheelValue: text)
    }
        
        Then("I(?: will|) wait ([^\\\"]*) seconds?$") { (args, userInfo) -> Void in
            if let args = args, let timeInSeconds = UInt32(args[0]) {
                sleep(timeInSeconds)
            }
        }
        
        //Another step definition
//        And("all data cleared") { (args, userInfo) -> Void in
//            //Assume you defined an "I tap on \"(.*)\" button" step previousely, you can call it from your code as well.
//            let testCase = userInfo?[kXCTestCaseKey] as? XCTestCase
//            SStep(testCase, "I tap the \"Clear All Data\" button")
//        }
        
        
        func fillInField(field: String, text: String){
            let myComponent = XCUIApplication().textFields[field]
            myComponent.tap()
            myComponent.typeText(text)
            myComponent.typeText("\n")
        }
        
        
        //Create a bundle for the folder that contains your "Features" folder. In this example, the CucumberishInitializer.swift file is in the same directory as the "Features" folder.
        let bundle = Bundle(for: CucumberishInitializer.self)
        
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
    }
}
