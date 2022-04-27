//
//  AlarmView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack (spacing: 32) {
                    VStack (alignment: .leading) {
                        sectionTitle(title: "BEDTIME", icon: "bed.double.fill")
                        Divider()
                        alarmTime(time: "06:00", type: "Weekdays")
                        Divider()
                    }
                }.padding()
                VStack (alignment: .leading) {
                    sectionTitle(title: "OTHER ALARMS", icon: "")
                    Divider()
                    alarmTime(time: "07:00", type: "Weekdays")
                    Divider()
                    alarmTime(time: "08:00", type: "Alarm")
                    Divider()
                    alarmTime(time: "09:00", type: "Alarm")
                    Divider()
                }
                .padding()
            }
//        }
    }
}

struct sectionTitle: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Text(title)
            Image(systemName: icon)
        }
        .font(.subheadline)
        .foregroundColor(.gray)
    }
}

struct alarmTime: View {
    @State var turnOn = false
    
    var time: String
    var type: String
    
    var body: some View {
        Toggle(isOn: $turnOn, label: {
            VStack(alignment: .leading) {
                Text(time)
                    .font(.system(size: 72))
                    .foregroundColor(turnOn ? .white : .gray)
                Text(type)
                    .font(.title2)
                    .foregroundColor(turnOn ? .white : .gray)
            }
        })
        .padding(.bottom, 16)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
