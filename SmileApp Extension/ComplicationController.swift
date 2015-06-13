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
        DataPoint(date: NSDate(), amountRaised: 340.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60), amountRaised: 296.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 2), amountRaised: 283.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 2.5), amountRaised: 280.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 2.7), amountRaised: 278.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 3), amountRaised: 271.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 4), amountRaised: 239.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 5), amountRaised: 220.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 6), amountRaised: 201.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 7), amountRaised: 191.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 8), amountRaised: 180.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 9), amountRaised: 170.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 12), amountRaised: 165.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 14), amountRaised: 160.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 24), amountRaised: 155.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 25), amountRaised: 131.0),
        DataPoint(date: NSDate().dateByAddingTimeInterval(-60 * 60 * 26), amountRaised: 0.0),
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
                let tmpl = templateForDataPoint(dataPoint, complication: complication)
                let entry = CLKComplicationTimelineEntry(date:thisDate, complicationTemplate:tmpl!)
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
                let tmpl = templateForDataPoint(dataPoint, complication: complication)
                let entry = CLKComplicationTimelineEntry(date:thisDate, complicationTemplate:tmpl!)
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
        let dataPoint = self.dataPoints[0]
        let tmpl = templateForDataPoint(dataPoint, complication: complication)
        handler(tmpl)
    }
    
    func templateForDataPoint(dataPoint: DataPoint, complication: CLKComplication) -> CLKComplicationTemplate? {
        switch complication.family {
            case CLKComplicationFamily.ModularLarge:
                let tmpl = CLKComplicationTemplateModularLargeStandardBody()
                
                tmpl.headerTextProvider = CLKSimpleTextProvider(text: "Amount Raised")
                tmpl.body1TextProvider = CLKSimpleTextProvider(text: "Raised $\(dataPoint.amountRaised)")
                
                return tmpl
            
            case CLKComplicationFamily.ModularSmall:
                let tmpl = CLKComplicationTemplateModularSmallSimpleText()
                let myIntValue:Int = Int(dataPoint.amountRaised)
                tmpl.textProvider = CLKSimpleTextProvider(text: "$\(myIntValue)")
        
                
                return tmpl

            case CLKComplicationFamily.CircularSmall:
                let tmpl = CLKComplicationTemplateCircularSmallRingText()
                let myIntValue:Int = Int(dataPoint.amountRaised)
                tmpl.textProvider = CLKSimpleTextProvider(text: "$\(myIntValue)")
                
                return tmpl
            
            case CLKComplicationFamily.UtilitarianSmall:
                let tmpl = CLKComplicationTemplateUtilitarianSmallRingText()
                let myIntValue:Int = Int(dataPoint.amountRaised)
                tmpl.textProvider = CLKSimpleTextProvider(text: "$\(myIntValue)")
            
                return tmpl
            
            case CLKComplicationFamily.UtilitarianLarge:
                let tmpl = CLKComplicationTemplateUtilitarianLargeFlat()
                
                tmpl.textProvider = CLKSimpleTextProvider(text: "Raised $\(dataPoint.amountRaised)")
                
                return tmpl
        }
    }
    
}
