//
//  CodingExerciseTests.swift
//  CodingExerciseTests
//
//  Created by Kaya Thomas on 6/29/18.
//  Copyright © 2018 slack. All rights reserved.
//

import XCTest
@testable import CodingExercise

class CodingExerciseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    
// MARK: - tests for Cache and Trie

    func testCache() {
        let cache = SearchCache.shared
        let query = String().random(Int.random(in: 1..<10))
        let dataString = String().random(Int.random(in: 100..<150))
        cache.cache(query, data: dataString.data(using: .utf8)!)
        guard let newData = cache.cached(for: query) else {
            XCTAssert(true, "Not saved")
            return
        }
    
        let newString = String(decoding: newData, as: UTF8.self)
        XCTAssert(newString == dataString, "Cached data corrupted")
        cache.reset()
        guard cache.cached(for: query) != nil else {
            return
        }
        XCTAssert(true, "reset failed")
    }
    
    
    func testTrie() {
        let trie  = WordTrie()
        trie.insert("abc")
        trie.insert("abcd")
        trie.insert("ab.df")
        trie.insert("aef")
        trie.insert("a123")
        
        XCTAssert(trie.hasPrefix(for: "d") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "de") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "cd") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "a") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "ae") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "aef") == true, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "aefg") == true, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "12") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "a.df") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: ".ab.df") == false, "Wrong prefix found")
        XCTAssert(trie.hasPrefix(for: "ab.df.") == true, "Wrong prefix found")

    }

}
