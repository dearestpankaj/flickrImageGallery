//
//  FlickrAppTests.swift
//  FlickrAppTests
//
//  Created by Pankaj Sachdeva on 7/29/17.
//  Copyright © 2017 Pankaj Sachdeva. All rights reserved.
//

import XCTest
@testable import FlickrApp
import ObjectMapper

class FlickrAppTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /// Test Photo object if created or not using ObjectMapper
    func testPhoto(){
        let jsonObject = ["farm":5,"server":"3","id":"36004677742","owner":"41687112@N06","secret":"6674ba90a2","title":"Multnomah Falls, Portland !!"] as [String : Any]
        let objPhoto = Mapper<Photo>().map(JSONObject: jsonObject)
        XCTAssertNotNil(objPhoto, "Unable to create Photo object")
        XCTAssertEqual(objPhoto?.farm, 5, "farm id is wrong")
    }
    
    func testGetPhotoURL(){
        let jsonObject = ["farm":5,"server":"3","id":"36004677742","owner":"41687112@N06","secret":"6674ba90a2","title":"Multnomah Falls, Portland !!"] as [String : Any]
        let objPhoto = Mapper<Photo>().map(JSONObject: jsonObject)
        let url = PhotoGalleryUtilities.getPhotoURL(flickrPhoto: objPhoto!)
        XCTAssertEqual(url, "https://farm5.staticflickr.com/3/36004677742_6674ba90a2.jpg", "unable to create url")
    }
    
    func testFetchPhotoList(){
        let expect = expectation(description: "FetchPhotoList")
        let photos = PhotoLibraryService()
        photos.fetchPhotoList(flickrUserID: flickerUser,successArrayResponse: {
            (arrResponse:[Photo]) -> Void in
            
            expect.fulfill()
        }, failure: {
            (data) -> Void in
            XCTAssertNil(data, "Whoops, error \(data)")
        })
        wait(for: [expect], timeout: 10)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
