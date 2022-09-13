//
//  TaskSWGTests.swift
//  TaskSWGTests
//
//  Created by Apple on 08/09/22.
//

import XCTest
@testable import TaskSWG

class TaskSWGTests: XCTestCase {
    
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testURLForPath() {
        let networking = WebServicesConstant.baseUrlwithKey
        XCTAssertEqual(networking, "https://api.weatherapi.com/v1/forecast.json?key=522db6a157a748e2996212343221502")
    }
    func testURLFailPath(){
        let networking = WebServicesConstant.baseUrlwithKey
        XCTAssertNotEqual(networking, "https://api.weatherapi.com/v1/forecast.json?key=")
    }
    
    
    func test_get_request_with_URL() {
        
        guard let url = URL(string: WebServicesConstant.WhetherForeCastApi) else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: WebServicesConstant.WhetherForeCastApi) else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: URL(string: WebServicesConstant.WhetherForeCastApi)!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}
