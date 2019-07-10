import XCTest

import curarTests

var tests = [XCTestCaseEntry]()
tests += curarTests.allTests()
XCTMain(tests)