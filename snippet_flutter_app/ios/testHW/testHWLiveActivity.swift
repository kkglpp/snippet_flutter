//
//  testHWLiveActivity.swift
//  testHW
//
//  Created by user on 12/27/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct testHWAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct testHWLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: testHWAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension testHWAttributes {
    fileprivate static var preview: testHWAttributes {
        testHWAttributes(name: "World")
    }
}

extension testHWAttributes.ContentState {
    fileprivate static var smiley: testHWAttributes.ContentState {
        testHWAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: testHWAttributes.ContentState {
         testHWAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: testHWAttributes.preview) {
   testHWLiveActivity()
} contentStates: {
    testHWAttributes.ContentState.smiley
    testHWAttributes.ContentState.starEyes
}
