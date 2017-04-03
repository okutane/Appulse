//
//  ComplicationController.swift
//  Appulse WatchKit Extension
//
//  Created by Dmitry Matveev on 01/04/2017.
//  Copyright © 2017 Dmitry Matveev. All rights reserved.
//

import ClockKit

protocol MagicDateProvider {
    func prev(current: Date) -> Date
    func next(current: Date) -> Date
}

let minute = TimeInterval(60)
let hour = TimeInterval(minute * 60)
let day = TimeInterval(hour * 24)

struct MagicMinute {
    var from: Date
    var to: Date {
        return from.addingTimeInterval(minute)
    }
    var bestSecond: Date?
}

// 00:00, 11:11, 22:22
struct RepeatingNumbers: MagicDateProvider {
    internal func prev(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let components = Calendar.current.dateComponents([.Year], fromDate: current)
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        if (combined > 2222) {
            components.hour = 22
            components.minute = 22
            return cal.date(from: components)!
        }

        if (combined > 1111) {
            components.hour = 11
            components.minute = 11
            return cal.date(from: components)!
        }

        if (combined > 0000) {
            components.hour = 0
            components.minute = 0
            return cal.date(from: components)!
        }

        components.day = components.day! - 1
        components.hour = 22
        components.minute = 22
        return cal.date(from: components)!
    }

    internal func next(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let components = Calendar.current.dateComponents([.Year], fromDate: current)
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        if (combined < 2222) {
            components.hour = 22
            components.minute = 22
            return cal.date(from: components)!
        }

        if (combined < 1111) {
            components.hour = 11
            components.minute = 11
            return cal.date(from: components)!
        }

        components.hour = 0
        components.minute = 0
        return cal.date(from: components)!
    }
}

class ComplicationController: NSObject, CLKComplicationDataSource {

    let provider: RepeatingNumbers = RepeatingNumbers()

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateUtilitarianLargeFlat()
        template.textProvider = CLKSimpleTextProvider(text: "13:37")
        
        handler(template)
    }

    func timelineEntryDateForMagicNumber(magicDate: MagicMinute) -> Date {

    }
}
