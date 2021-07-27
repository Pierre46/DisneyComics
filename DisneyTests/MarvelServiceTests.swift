//
//  MarvelServiceTests.swift
//  DisneyTests
//
//  Created by Pierre Moreau on 7/25/21.
//

import XCTest
@testable import Disney


class MarvelServiceTests: XCTestCase {

    func testGeneratingHashPerDeveloperMarvelRequirement() {
        //Given (testing example provided in https://developer.marvel.com/documentation/authorization)
        let date = "1", publicKey = "1234", privateKey = "abcd"
        let hash = whenGeneratingHashValue(date: date, publicKey: publicKey, privateKey: privateKey)
        thenHashValueIsValid(hash: hash, expectedResult: "ffd275c5130566a2916217b101f26150")
    }
    
    
    //MARK: - Private functions
    
    private func whenGeneratingHashValue(date: String, publicKey: String, privateKey: String) -> String {
        MarvelService().generateHash(date: date, publicKey: publicKey, privateKey: privateKey)
    }
    
    private func thenHashValueIsValid(hash: String, expectedResult: String) {
        XCTAssertEqual(hash, expectedResult)
    }
}
