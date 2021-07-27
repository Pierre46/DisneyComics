//
//  DisneyUITests.swift
//  DisneyUITests
//
//  Created by Pierre Moreau on 7/25/21.
//

import XCTest

class DisneyUITests: XCTestCase {
    
    var app: XCUIApplication!
    let expectedComicTitle = "ULTIMATE X-MEN VOL. 5: ULTIMATE WAR TPB (Trade Paperback)"
    let expectedComicDescription = "The Ultimates vs. the Ultimate X-Men: the battle begins. When the X-Men do the worst thing they could to humanity, the government orders Captain America, Iron Man, Thor and the rest of the Ultimates to bring them down. A small but lethal army, the Ultimates were created to face these and other newly rising threats to mankind. But the X-Men\'s founder, Professor X, hasn\'t been training his students for nothing -- and the youngs mutants just might take out the Ultimates first."

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testExample() throws {
        
        /* Using API call so it needs to wait for the response.
        This test could also mock API responses depending on preferences */
        sleep(1)
        
        let title = app.staticTexts["comic_title"].label
        let description = app.staticTexts["comic_description"].label
        let thumbnail = app.images["comic_thumbnail"]
        
        XCTAssertEqual(title, expectedComicTitle)
        XCTAssertEqual(description, expectedComicDescription)
        XCTAssertTrue(thumbnail.exists)
    }
}
