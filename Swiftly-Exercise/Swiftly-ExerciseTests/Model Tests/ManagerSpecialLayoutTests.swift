//
//  Swiftly_ExerciseTests.swift
//  Swiftly-ExerciseTests
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import XCTest
@testable import Swiftly_Exercise

internal class BaseCase: XCTestCase {

    /// Loads and returns JSON data from the bundle.
    internal final func data(from jsonFile: String) -> Data {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: jsonFile, withExtension: "json") else {
            fatalError("🙋🏽‍♀️ file \(jsonFile) not found.")
        }

        do {
            return try Data(contentsOf: url)
        } catch { fatalError("Failed to initialize data ☹️") }
    }
}

class ManagerSpecialLayoutTests: BaseCase {
    
    var layout: ManagerSpecialLayout?

    override func setUp() {
        if let decodedLayout = try? JSONDecoder().decode(ManagerSpecialLayout.self, from: data(from: "ManagerSpecialLayout")) {
            layout = decodedLayout
        } else {
            fatalError("Failed to decode data ☹️")
        }
    }

    func testManagerSpecialLayout_didInitializeCorrectly() {
        XCTAssertEqual(layout?.canvasUnit, 16)
        XCTAssertEqual(layout?.managerSpecials.count, 21)
    }
    
}

class ManagerSpecialItemTests: BaseCase {
    
    var layout: ManagerSpecialLayout?

    override func setUp() {
        if let decodedLayout = try? JSONDecoder().decode(ManagerSpecialLayout.self, from: data(from: "ManagerSpecialLayout")) {
            layout = decodedLayout
        } else {
            fatalError("Failed to decode data ☹️")
        }
    }

    func testManagerSpecialItem_firstItem_didInitializeCorrectly() {
        XCTAssertEqual(layout?.managerSpecials[0].displayName, "Noodle Dish with Roasted Black Bean Sauce")
        XCTAssertEqual(layout?.managerSpecials[0].height, 8)
        XCTAssertEqual(layout?.managerSpecials[0].width, 16)
        XCTAssertEqual(layout?.managerSpecials[0].imageUrl, "https://raw.githubusercontent.com/prestoqinc/code-exercise-ios/master/images/L.png")
        XCTAssertEqual(layout?.managerSpecials[0].originalPrice, "2.00")
        XCTAssertEqual(layout?.managerSpecials[0].price, "1.00")
    }
    
}
