//
//  DataGenerationTests.swift
//  JournalTests
//
//  Created by Jill Allan on 03/10/2023.
//

import SwiftData
import XCTest
@testable import Journal

final class JournalDataContainerTests: BaseTestCase {
    var fakeDataGeneration: FakeDataGeneration.Type!
    var journalDataContainer: JournalDataContainer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testDataGeneration2() throws {
        let container = TestDataContainer(inMemory: true)
        
        container.dataGeneration.generateData(modelContext: container.container.mainContext)
        let descriptor = FetchDescriptor<Trip>()
        let trips = try container.container.mainContext.fetchCount(descriptor)
       
        XCTAssertEqual(trips, 2)

    }

    override func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

struct MockContainer {
    let container: ModelContainer
    var dataGeneration: DataGenerationTestable.Type = DataGeneration.self
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
            print(String(describing: container))
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
    }
}

class FakeDataGeneration: DataGenerationTestable {
    static func generateData(modelContext: ModelContext) {
        modelContext.insert(Trip.bedminsterToBeijing)
        modelContext.insert(Trip.mountains)
        
        modelContext.insert(Activity.templeMeads)
        modelContext.insert(Activity.templeMeadsToPaddington)
        modelContext.insert(Activity.paddington)

        modelContext.insert(Step.templeMeadsStation)
        modelContext.insert(Step.bathSpaStation)
        modelContext.insert(Step.chippenhamStation)
        modelContext.insert(Step.swindonStation)
        modelContext.insert(Step.didcotStation)
        modelContext.insert(Step.readingStation)
        modelContext.insert(Step.paddingtonStation)
        
        modelContext.insert(Placemark.templeMeadsStation)
        modelContext.insert(Placemark.bathSpaStation)
        modelContext.insert(Placemark.chippenhamStation)
        modelContext.insert(Placemark.swindonStation)
        modelContext.insert(Placemark.didcotStation)
        modelContext.insert(Placemark.readingStation)
        modelContext.insert(Placemark.paddingtonStation)

        Activity.templeMeads.trip = Trip.bedminsterToBeijing
        Activity.templeMeadsToPaddington.trip = Trip.bedminsterToBeijing
        Activity.paddington.trip = Trip.bedminsterToBeijing
        
        Activity.templeMeads.suceedingActivity = Activity.templeMeadsToPaddington
        Activity.templeMeadsToPaddington.suceedingActivity = Activity.paddington

        Step.templeMeadsStation.activity = Activity.templeMeads
        Step.bathSpaStation.activity = Activity.templeMeadsToPaddington
        Step.chippenhamStation.activity = Activity.templeMeadsToPaddington
        Step.swindonStation.activity = Activity.templeMeadsToPaddington
        Step.didcotStation.activity = Activity.templeMeadsToPaddington
        Step.readingStation.activity = Activity.templeMeadsToPaddington
        Step.paddingtonStation.activity = Activity.paddington
        
        Step.templeMeadsStation.placemark = Placemark.templeMeadsStation
        Step.bathSpaStation.placemark = Placemark.bathSpaStation
        Step.chippenhamStation.placemark = Placemark.chippenhamStation
        Step.swindonStation.placemark = Placemark.swindonStation
        Step.didcotStation.placemark = Placemark.didcotStation
        Step.readingStation.placemark = Placemark.readingStation
        Step.paddingtonStation.placemark = Placemark.paddingtonStation
    }

}
