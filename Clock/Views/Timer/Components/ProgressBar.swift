//
//  ProgressBar.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI
import AVFoundation

struct ProgressBar: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject private var model: TimerVM
    
    var body: some View {
        ZStack {
            VStack {
                Text(model.timeFormatter)
                    .font(.system(size: 60))
                    .fontWeight(.thin)
            }
            Circle()
                .fill(Color.clear)
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color(.secondarySystemBackground), lineWidth: 8))
                .overlay(overlayCircle)
            .animation(.linear(duration: 1.0), value: "TimerVM")
        }
    }
    
    private var overlayCircle: some View {
        Circle()
            .fill(Color.clear)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .trim(from: 0, to: CGFloat(min(model.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin:.round))
                    .rotationEffect(Angle(degrees: 270.0))
                    .foregroundColor(Color(model.isRunning ? .systemGreen : .systemOrange))
                    .animation(.linear(duration: 1.0), value: "TimerVM")
            )
    }
    
    private var size: CGFloat {
        horizontalSizeClass == .compact ? UIScreen.main.bounds.width * 0.9 : 540
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar()
//            .environmentObject(TimerVM())
//    }
//}
