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
        var application : XCUIApplication!
        //A closure that will be executed only before executing any of your features
        beforeStart { () -> Void in
            //Any global initialization can go here
            XCUIApplication.init().launch()

        }
        before({ _ in
            XCUIApplication().launch()
        })
        //A Given step definition
        Given("the app is running") { (args, userInfo) -> Void in
            XCTAssert(false)
        }
        //Another step definition
        And("all data cleared") { (args, userInfo) -> Void in
            //Assume you defined an "I tap on \"(.*)\" button" step previousely, you can call it from your code as well.
            let testCase = userInfo?[kXCTestCaseKey] as? XCTestCase
            SStep(testCase, "I tap the \"Clear All Data\" button")
        }
        //Create a bundle for the folder that contains your "Features" folder. In this example, the CucumberishInitializer.swift file is in the same directory as the "Features" folder.
        let bundle = Bundle(for: CucumberishInitializer.self)
        
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
    }
}
