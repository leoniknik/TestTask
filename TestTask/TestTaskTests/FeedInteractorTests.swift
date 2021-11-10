//
//  TestTaskTests.swift
//  TestTaskTests
//
//  Created by Кирилл Володин on 01.11.2021.
//

import XCTest
@testable import TestTask

// We also can use Quick for more flexible testing
class FeedInteractorTests: XCTestCase {
    
    var mockPhotos: [Photo] = [.init(dto: .init(id: "1", title: "Test", urlSquare: "", urlMedium: ""))]
    var output: FeedModuleOutputMock!
    var service: FeedServiceMock!
    var presenter: FeedPresenterMock!
    var interactor: FeedInteractor!
    
    override func setUp() {
        output = FeedModuleOutputMock()
        service = FeedServiceMock()
        presenter = FeedPresenterMock()
        interactor = FeedInteractor(output: output, presenter: presenter, feedService: service, worker: WorkerMock())
    }

    func testWhenDidSelectItemShouldAskOutputToShowPhoto() {
        // given
        service.mockData = mockPhotos
        interactor.didSearch(text: "some")
        
        // when
        let index = 0
        interactor.didSelectItem(with: index)
       
        // then
        XCTAssert(output.didSelectPhotoWasCalled)
        XCTAssert(output.didSelectParams == mockPhotos[index])
    }
    
    func testWhenDidSearchFirstTimeNonEmptyTextShouldObtainPhotos() {
        // given
        service.mockData = mockPhotos
        
        // when
        interactor.didSearch(text: "some")
       
        // then
        XCTAssert(service.obtainPhotosWasCalled)
        XCTAssert(presenter.presentIsLoadingWasCalled)
        XCTAssert(presenter.presentPhotosWasCalled)
        XCTAssert(presenter.presentPhotosParams == service.mockData)
    }
    
    func testWhenDidSearchTextEqualsPreviousTextShouldNotObtainPhotos() {
        // given
        service.mockData = mockPhotos
        
        // when
        interactor.didSearch(text: "some")
        interactor.didSearch(text: "some")
       
        // then
        XCTAssert(service.obtainPhotosCallsNumber == 1)
    }
    
    func testWhenClearTextShouldNotObtainPhotos() {
        // given
        service.mockData = mockPhotos
        
        // when
        interactor.didSearch(text: "")
       
        // then
        XCTAssert(service.obtainPhotosWasCalled == false)
    }
}

// We can use autogenerate mocks by using MockingBird and for verify(inOrder) checks
class FeedServiceMock: FeedServiceProtocol {
    
    var obtainPhotosCallsNumber = 0
    var obtainPhotosWasCalled = false
    var mockData: [Photo] = []
    
    func obtainPhotos(
        tags: String,
        page: Int,
        batchSize: Int,
        completion: @escaping (Result<[Photo], Error>) -> ()
    ) -> Cancelable? {
        obtainPhotosWasCalled = true
        obtainPhotosCallsNumber += 1
        completion(.success(mockData))
        return nil
    }
}

class FeedModuleOutputMock: FeedModuleOutput {
    var didSelectPhotoWasCalled = false
    var didSelectParams: Photo?
    
    func didSelect(photo: Photo) {
        didSelectParams = photo
        didSelectPhotoWasCalled = true
    }
}

class FeedPresenterMock: FeedPresentationLogic {
    
    var presentPhotosWasCalled = false
    var presentPhotosParams: [Photo] = []
    
    var presentErrorWasCalled = false
    
    var presentIsLoadingWasCalled = false
    
    func presentPhotos(_ photos: [Photo]) {
        presentPhotosParams = photos
        presentPhotosWasCalled = true
    }
    
    func presentError() {
        presentErrorWasCalled = true
    }
    
    func present(isLoading: Bool) {
        presentIsLoadingWasCalled = true
    }
}

class WorkerMock: FeedDebounceWorkerProtocol {
    func debounce(block: @escaping () -> ()) {
        block()
    }
}

extension Photo: Equatable {
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.id == rhs.id
    }
}

//private weak var output: FeedModuleOutput?
//private let presenter: FeedPresentationLogic
//private let feedService: FeedServiceProtocol
//private let page = 1
//private let batchSize = 20
//private var photos: [Photo] = []
//private let debouncer = Debouncer(delay: 1.5)
//private var lastSearchText = ""
//private var job: Cancelable?
//
//init(output: FeedModuleOutput, presenter: FeedPresentationLogic, feedService: FeedServiceProtocol) {
//    self.output = output
//    self.presenter = presenter
//    self.feedService = feedService
//}
//}
//
//private func obtainPhotos(text: String) {
//    guard text != lastSearchText, text != "" else { return }
//    lastSearchText = text
//    presenter.present(isLoading: true)
//    job?.cancel()
//    job = feedService.obtainPhotos(tags: text, page: page, batchSize: batchSize) { [weak self] result in
//        switch result {
//        case let .success(photos):
//            self?.photos = photos
//            self?.presenter.present(isLoading: false)
//            self?.presenter.presentPhotos(photos)
//        case .failure:
//            self?.presenter.presentError()
//        }
//    }
//}
