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

        let app = XCUIApplication()

        beforeStart { () -> Void in
            //Any global initialization can go here

        }
        
        Given("that the app is opened") { (args, userInfo) -> Void in
            XCUIApplication().launch()
        }
        
        //        This step is here only to match with the Android Version, it actually does nothing
        Then("the app will be closed") { (args, userInfo) -> Void in
        }
        
        Then("^I (?:will )?assert that the (text|id) \"([^\"]*)\" (?:is|has the text) \"?([^\"]*)\"?$"){ (args, userInfo) -> Void in
            let typeOfField = (args?[0])!
            let textValueOrId = (args?[1])!
            let visibleOrIdValue = (args?[2])!
            let shouldBeVisible = visibleOrIdValue.elementsEqual("visible")
            
            switch(typeOfField){
            case "id":
                assertTextById(id: textValueOrId, text: visibleOrIdValue)
            case "text":
                assertText(shouldBeVisible: shouldBeVisible, text: textValueOrId)
            default:
                scenarioNotMapped()
            }
            
        }

        
        When("^I click on button \"([^\"]*)\"$"){ (args, userInfo) -> Void in
            let button = (args?[0])!
            clickOnButton(button: button)
        }
        
        When("^I click on (text|button) \"([^\"]*)\"$"){ (args, userInfo) -> Void in
            let typeOfField = (args?[0])!
            let textOrId = (args?[1])!
            switch(typeOfField){
            case "text":
                clickOnText(text: textOrId)
            case "button":
                clickOnButton(button: textOrId)
            default:
                scenarioNotMapped()
            }
        }
        
        When("^I swipe (left|right) on the text \"([^\"]*)\"$"){ (args, userInfo) -> Void in
            let direction = (args?[0])!
            let text = (args?[1])!
            swipe(text: text, direction: direction)
        }
        
        When("I fill in the (field|search bar) \"([^\\\"]*)\" with the text \"([^\\\"]*)\"$") { (args, userInfo) -> Void in
            let typeOfField = (args?[0])!
            let field = (args?[1])!
            let text = (args?[2])!
            
            switch(typeOfField){
            case "field":
                fillInField(field: field, text: text)
            case "search bar":
                fillInSearchBar(placeholder: field, text: text)
            default:
                scenarioNotMapped()
            }
            
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
        
//        Step Definition Functions
        
        func fillInField(field: String, text: String){
            let myComponent = XCUIApplication().textFields[field]
            myComponent.tap()
            myComponent.typeText(text)
            myComponent.typeText("\n")
        }
        
        func fillInSearchBar(placeholder: String, text: String){
            let myComponent = XCUIApplication().searchFields[placeholder]
            myComponent.tap()
            myComponent.typeText(text)
        }
        
        func clickOnButton(button: String){
            app.buttons[button].tap()
        }
        
        func clickOnText(text: String){
            app.staticTexts[text].tap()
        }
        
        func swipe(text: String, direction: String){
            if(direction.elementsEqual("left")){
                app.staticTexts[text].swipeLeft()
            }
            else {
                app.staticTexts[text].swipeRight()
            }
        }
        
        func scenarioNotMapped(){
            print("Scenario not mapped")
            XCTAssert(false)
        }
        
        func assertText(shouldBeVisible: Bool, text: String){
            if(shouldBeVisible){
                XCTAssert(app.staticTexts[text].exists)
            }
            else{
                XCTAssert(!app.staticTexts[text].exists)
            }
        }
        
        func assertTextById(id: String, text: String){
            XCTAssertEqual(app.staticTexts[id].label, text)
        }
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
    }
}
