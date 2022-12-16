//
//  EmojiRangerWidget.swift
//  EmojiRangerWidget
//
//  Created by 아톰릭스랩 on 2022/12/16.
//  Copyright © 2022 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), character: .panda)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, character: .panda)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), configuration: configuration, character: .panda)]

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration, character: .panda)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let character: CharacterDetail
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
//        Text(entry.date, style: .time)
        AvatarView(entry.character)
    }
}

@main
struct EmojiRangerWidget: Widget {
    let kind: String = "EmojiRangerWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EmojiRangerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct EmojiRangerWidget_Previews: PreviewProvider {
    static var previews: some View {
//        EmojiRangerWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
        AvatarView(.panda)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
