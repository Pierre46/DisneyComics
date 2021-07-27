//
//  ComicViewModelTests.swift
//  DisneyTests
//
//  Created by Pierre Moreau on 7/27/21.
//

import XCTest
@testable import Disney

class ComicViewModelTests: XCTestCase {

    var viewModel: ComicViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = ComicViewModel()
    }
    
    func testsComicViewModelSuccessfullState() {
        let comic = givenMockedBackendSuccessfullResponse()
        whenViewModelLoadsComicData()
        thenViewModelStateIsSetToSucessWithCorrect(comic: comic)
    }
    
    func testsComicViewModelErrorState() {
        let error = givenMockedBackendErrorResponse()
        whenViewModelLoadsComicData()
        thenViewModelStateIsSetToFailedWithCorrect(error: error)
    }
    
    
    //MARK: - Private functions
    
    private func givenMockedBackendSuccessfullResponse() -> Comic {
        let comic = Comic(id: 56, title: "Title", description: "Description")
        let mockedServiceLayer = ComicsManagerMock()
        mockedServiceLayer.success = comic
        viewModel.service = mockedServiceLayer
        
        return comic
    }
    
    private func givenMockedBackendErrorResponse() -> MarvelError {
        let error = MarvelError(title: "Title", message: "Message")
        let mockedServiceLayer = ComicsManagerMock()
        mockedServiceLayer.error = error
        viewModel.service = mockedServiceLayer
        
        return error
    }
    
    private func whenViewModelLoadsComicData() {
        viewModel.loadComic()
    }
    
    private func thenViewModelStateIsSetToSucessWithCorrect(comic: Comic) {
        switch viewModel.comicState.value {
            case .success(comic: let responseComic):
                XCTAssertEqual(comic.id, responseComic.id)
                XCTAssertEqual(comic.title, responseComic.title)
                XCTAssertEqual(comic.description, responseComic.description)
                
            default:
                XCTFail()
        }
    }
    
    private func thenViewModelStateIsSetToFailedWithCorrect(error: MarvelError) {
        switch viewModel.comicState.value {
            case .failure(error: let responseError):
                XCTAssertEqual(error.title, responseError.title)
                XCTAssertEqual(error.message, responseError.message)
                
            default:
                XCTFail()
        }
    }
}

//There is different ways to acheive Mocking, I could have also used Protocols as well for example.
private class ComicsManagerMock: ComicsManager {
    var success: Comic?
    var error: MarvelError?
    
    override func retreiveComic(id: Int,
                       successCompletion: @escaping (Comic) -> (),
                       errorCompletion: @escaping (MarvelError) -> ()) {
        
        if let success = success {
            successCompletion(success)
        }
        else if let error = error {
            errorCompletion(error)
        }
    }
}
