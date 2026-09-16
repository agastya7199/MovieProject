//
//  MovieProjectTests.swift
//  MovieProjectTests
//
//  Created by Mouli Agastya on 9/9/26.
//

import XCTest
@testable import MovieProject

final class MovieProjectTests: XCTestCase {
    var objCalculator: Calculator?
    var movieViewModel: MovieViewModelProtocol?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        objCalculator = Calculator()
        movieViewModel = MockMovieViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        objCalculator = nil
        movieViewModel = nil
    }
    
    func testSum() {
        let sumResult1 = objCalculator?.sum(num1: 2, num2: 4)
        XCTAssertEqual(sumResult1, 6)
        
        let sumResult2 = objCalculator?.sum(num1: nil, num2: 20)
        XCTAssertEqual(sumResult2, 0)
        
        let sumResult3 = objCalculator?.sum(num1: -5, num2: nil)
        XCTAssertEqual(sumResult3, 0)
        
        let sumResult4 = objCalculator?.sum(num1: nil, num2: nil)
        XCTAssertEqual(sumResult4, 0)
    }
    
    func testSub() {
        let subResult1 = objCalculator?.sub(num1: 2, num2: 4)
        XCTAssertEqual(subResult1, -2)
        
        let subResult2 = objCalculator?.sub(num1: nil, num2: 20)
        XCTAssertEqual(subResult2, 0)
        
        let subResult3 = objCalculator?.sub(num1: -5, num2: nil)
        XCTAssertEqual(subResult3, 0)
        
        let subResult4 = objCalculator?.sub(num1: nil, num2: nil)
        XCTAssertEqual(subResult4, 0)
    }
    
    func testMul() {
        let mulResult1 = objCalculator?.mul(num1: 2, num2: 4)
        XCTAssertEqual(mulResult1, 8)
        
        let mulResult2 = objCalculator?.mul(num1: nil, num2: 20)
        XCTAssertEqual(mulResult2, 0)
        
        let mulResult3 = objCalculator?.mul(num1: -5, num2: nil)
        XCTAssertEqual(mulResult3, 0)
        
        let mulResult4 = objCalculator?.mul(num1: nil, num2: nil)
        XCTAssertEqual(mulResult4, 0)
    }
    
    func testDiv() {
        let divResult1 = objCalculator?.div(num1: 4, num2: 2)
        XCTAssertEqual(divResult1, 2)
        
        let divResult2 = objCalculator?.div(num1: nil, num2: 20)
        XCTAssertEqual(divResult2, 0)
        
        let divResult3 = objCalculator?.div(num1: -5, num2: nil)
        XCTAssertEqual(divResult3, 0)
        
        let divResult4 = objCalculator?.div(num1: nil, num2: nil)
        XCTAssertEqual(divResult4, 0)
    }
    
    func testFetchTotalMoviesCount() {
        let count = movieViewModel?.fetchTotalMoviesCount()
        XCTAssertEqual(count, 0)
    }
    
    func testFetchMovie() {
        let movie = movieViewModel?.fetchMovie(index: 0)
        // XCTAssertNotNil(movie)
        XCTAssertNil(movie)
    }
}
