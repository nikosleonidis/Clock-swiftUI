//
//  ContentView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(TimerVM())
    }
}

struct ContentView: View {
    
    @AppStorage("selectedIndex") private var selectedIndex: Int = 0
    @EnvironmentObject private var model: TimerVM
    
    var body: some View {
        ZStack {
            if selectedIndex == 0 || selectedIndex == 1 {
             NavigationView {
                 HStack {
                     Text("Add")
                     Spacer()
                     Text("Edit")
                 }
             }
            } else { }
            
            TabView(selection: $selectedIndex) {
                WorldClockBar()
                AlarmBar()
                StopWatchBar()
                TimerBar()
            }.accentColor(.orange)
            
        }.edgesIgnoringSafeArea(.all)
        .environmentObject(TimerVM())
        .preferredColorScheme(.dark)
    }
}

struct WorldClockBar: View {
    var body: some View {
        WorldClockView()
            .tabItem {
                Image(systemName: "globe")
                Text("World Clock")
            }.tag(0)
    }
}

struct AlarmBar: View {
    var body: some View {
        AlarmView()
            .tabItem {
                Image(systemName: "alarm")
                Text("Alarm")
            }.tag(1)
    }
}

struct StopWatchBar: View {
    var body: some View {
        StopWatchView()
            .tabItem {
                Image(systemName: "stopwatch")
                Text("Stopwatch")
            }.tag(2)
    }
}

struct TimerBar: View {
    var body: some View {
        TimerView(selectedIndex: .constant(3), to: .constant(0.0))
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }.tag(3)
    }
}
