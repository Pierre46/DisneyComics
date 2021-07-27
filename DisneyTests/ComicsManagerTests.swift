//
//  ComicsManagerTests.swift
//  DisneyTests
//
//  Created by Pierre Moreau on 7/26/21.
//

import XCTest
@testable import Disney


class ComicsManagerTests: XCTestCase {

    func testLoadSpiderManbComicFromMarvelBackend() throws {
        let comicId = givenSpiderManComicId()
        let response = whenCallMarvelAPI(comicId: comicId)
        thenComicIsValid(comic: response, expectedComic: expectedSpiderManComic)
    }
    
    
    //MARK: - Private functions
    
    private func givenSpiderManComicId() -> Int {
        return expectedSpiderManComic.id
    }
    
    private func whenCallMarvelAPI(comicId: Int) -> Comic? {
        let expectation = expectation(description: "Load comic from Marvel API")
        var resultComic: Comic?
        
        ComicsManager().retreiveComic(id: comicId, successCompletion: { comic in
            
            resultComic = comic
            expectation.fulfill()
        },
        errorCompletion: {
            error in
            
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        return resultComic
    }
    
    private func thenComicIsValid(comic: Comic?, expectedComic: Comic) {
        XCTAssertEqual(comic?.id, expectedComic.id)
        XCTAssertEqual(comic?.title, expectedComic.title)
        XCTAssertEqual(comic?.thumbnail, expectedComic.thumbnail)
        XCTAssertEqual(comic?.description, expectedComic.description)
    }
    
    private let expectedSpiderManComic = Comic(id: 3,
                                               title: "THE PULSE VOL. 1: THIN AIR TPB (Trade Paperback)",
                                               thumbnail: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/90/4bc6b7134bd0b.jpg")!,
                                               description: "It's an inside look at the Marvel Universe's most notorious newspaper, the Daily Bugle! Former super hero and current private investigator Jessica Jones has just been offered a new job: a position with the Bugle's new super-hero section, The Pulse! Jessica's first assignment: to uncover the true identity of a former Bugle reporter's super-powered murderer! How is millionaire industrialist Norman Osborn involved in the case? And how will Jessica's shocking discovery affect the entire Marvel Universe? Collecting THE PULSE #1-5.")
}
