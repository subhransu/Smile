//
//  ComplicationController.swift
//  SmileApp Extension
//
//  Created by Behera, Subhransu on 6/13/15.
//  Copyright © 2015 subhb.org. All rights reserved.
//

import ClockKit


struct DataPoint {
    var date: NSDate;
    var amountRaised: Double = 0.0;
}

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let dataPoints = [
        DataPoint(date: NSDate(), amountRaised: 300.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60), amountRaised: 200.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 24), amountRaised: 100.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 24 * 2), amountRaised: 50.0),
    ]
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let lastDataPoint = self.dataPoints.last
        handler(lastDataPoint?.date)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(self.dataPoints[0].date)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        getTimelineEntriesForComplication(complication, beforeDate: NSDate(), limit: 1) { (entries) -> Void in
            handler(entries?.first)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        for dataPoint in self.dataPoints {
            let thisDate = dataPoint.date
            if date.compare(thisDate) == .OrderedDescending {
                let tmpl = templateForDataPoint(dataPoint)
                let entry = CLKComplicationTimelineEntry(date:thisDate, complicationTemplate:tmpl)
                entries.append(entry)
                if entries.count == limit { break }
            }
        }
        
        handler(entries)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        var entries = [CLKComplicationTimelineEntry]()
        for dataPoint in self.dataPoints {
            let thisDate = dataPoint.date
            if date.compare(thisDate) == .OrderedAscending {
                let tmpl = templateForDataPoint(dataPoint)
                let entry = CLKComplicationTimelineEntry(date:thisDate, complicationTemplate:tmpl)
                entries.append(entry)
                if entries.count == limit { break }
            }
        }
        
        handler(entries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        switch complication.family {
            case CLKComplicationFamily.ModularLarge:
                let tmpl = CLKComplicationTemplateModularLargeStandardBody()
            
                tmpl.headerTextProvider = CLKSimpleTextProvider(text: "Stores Nearby")
                tmpl.body1TextProvider = CLKSimpleTextProvider(text: "There are 20 stores nearby")
            
                handler(tmpl)
            
            case CLKComplicationFamily.ModularSmall:
                let tmpl = CLKComplicationTemplateModularSmallSimpleText()
                tmpl.textProvider = CLKSimpleTextProvider(text: "Some Text")
            
                handler(tmpl)
            
            default:
                handler(nil)
        }
    }
    
    func templateForDataPoint(dataPoint: DataPoint) -> CLKComplicationTemplate {
        let tmpl = CLKComplicationTemplateModularLargeStandardBody()
        
        tmpl.headerTextProvider = CLKSimpleTextProvider(text: "Amount Raised")
        tmpl.body1TextProvider = CLKSimpleTextProvider(text: "Raised $\(dataPoint.amountRaised)")
        return tmpl
    }
    
}
