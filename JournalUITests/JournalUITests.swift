//
//  JournalUITests.swift
//  JournalUITests
//
//  Created by Jill Allan on 19/10/2023.
//

import XCTest
@testable import Journal

final class JournalUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTripView_TapAddTripButton_LaunchesAddTripSheet() {
        
        let addTripButton = app.buttons["Add trip"]
        
        // if
        // Check we can get to tabview trips exists and is hittable
        XCTAssert(addTripButton.isHittable)
        
        // when
        addTripButton.tap()
        
        // then
        XCTAssert(app.staticTexts["Add Trip"].exists)
    }
    
    func pickDate(app: XCUIApplication, newDate: Date) {
        let showYearPicker = app.buttons["Show year picker"]
        // Button, 0x10370e940, {{48.7, 299.3}, {133.7, 28.3}}, label: 'Show year picker', value: October 2023
        
        XCTAssert(showYearPicker.isHittable)
        showYearPicker.tap()
        
        let calendar = Calendar.current
        let today = Date.now
        
        
    
        let yearPickerWheel = app.pickerWheels[DateFormatter.year.string(from: today)]
        XCTAssert(yearPickerWheel.isHittable)
        
        yearPickerWheel.adjust(toPickerWheelValue: DateFormatter.year.string(from: newDate))
        
        let monthPickerWheel = app.pickerWheels[DateFormatter.monthLong.string(from: today)]
        XCTAssert(monthPickerWheel.isHittable)
        
        monthPickerWheel.adjust(toPickerWheelValue: DateFormatter.monthLong.string(from: newDate))
        
        let hideYearPicker = app.buttons["Hide year picker"]
        XCTAssert(hideYearPicker.isHittable)
        
        hideYearPicker.tap()
        
        newDate.formatted(Date.FormatStyle().weekday(.wide))
        
//        let newDateString = newDate.formatted(date: .long, time: .omitted)
        
     
        let newDateString = newDate.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day(.defaultDigits))

        
        let dayOfMonth = app.buttons[newDateString]//[DateFormatter.dayOrdinal_dd.string(from: newDate)] //Monday, December 26
        XCTAssert(dayOfMonth.isHittable)
        
        dayOfMonth.tap()
        app/*@START_MENU_TOKEN@*/.buttons["PopoverDismissRegion"]/*[[".buttons[\"dismiss popup\"]",".buttons[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testAddTripView_SaveNewTrip_CreatesAndNavigationsToNewTrip() throws {
        
        testTripView_TapAddTripButton_LaunchesAddTripSheet()
        
        let titleTextField = app.textViews["Title"]
        XCTAssert(titleTextField.isHittable)
//        XCTAssert(titleTextField.value == nil)
        
        titleTextField.tap()
        
        let tripTitle = String.randomWord()
        titleTextField.typeText(tripTitle)
        
        
        let startDatePicker = app.datePickers.element(boundBy: 0)
        XCTAssert(startDatePicker.isHittable)
        
        XCTAssertEqual(app.datePickers.buttons.element(boundBy: 0).value as? String, "Oct 21, 2023")
        
        startDatePicker.tap()
        
        let startDateString = Date.randomBetween(start: "2020-01-01", end: "2023-01-01", format: "yyyy-MM-dd")
        let startDate = Date.from(string: startDateString, format: "yyyy-MM-dd")
        pickDate(app: app, newDate: startDate)
        
        let endDatePicker = app.datePickers.element(boundBy: 1)
        XCTAssert(endDatePicker.isHittable)
        endDatePicker.tap()

        let endDateString = Date.randomBetween(start: "2023-01-01", end: "2026-01-01", format: "yyyy-MM-dd")
        let endDate = Date.from(string: endDateString, format: "yyyy-MM-dd")
        pickDate(app: app, newDate: startDate)
        
        app.navigationBars["Add Trip"]/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements[\"Save\"].buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.staticTexts[tripTitle].exists)
       

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
