//
//  ComplicationController.swift
//  Appulse WatchKit Extension
//
//  Created by Dmitry Matveev on 01/04/2017.
//  Copyright © 2017 Dmitry Matveev. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    let formatter : DateFormatter = DateFormatter()
    let provider: MagicDateProvider = RepeatingNumbers()

    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date.distantPast)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date.distantFuture)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let date = provider.next(current: Date())
        handler(getEntry(for: date))
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        var entries = [CLKComplicationTimelineEntry]()

        var entryDate = date
        while entries.count < limit {
            entryDate = provider.prev(current: date)
            entries.append(getEntry(for: entryDate))
        }

        handler(entries)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        var entries = [CLKComplicationTimelineEntry]()

        var entryDate = date
        while entries.count < limit {
            entryDate = provider.next(current: date)
            entries.append(getEntry(for: entryDate))
        }

        handler(entries)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateUtilitarianLargeFlat()
        template.textProvider = CLKSimpleTextProvider(text: "13:37")
        
        handler(template)
    }

    func getEntry(for date: Date) -> CLKComplicationTimelineEntry {
        // Always show next date starting from the end of previous
        return CLKComplicationTimelineEntry(date: provider.prev(current: date).addingTimeInterval(60), complicationTemplate: getTemplate(for: date))
    }

    func getTemplate(for date: Date) -> CLKComplicationTemplate {
        let template = CLKComplicationTemplateUtilitarianLargeFlat()

        formatter.dateFormat = "HH:mm"

        template.textProvider = CLKSimpleTextProvider(text: "Get at " + formatter.string(from: date))

        return template
    }
}
