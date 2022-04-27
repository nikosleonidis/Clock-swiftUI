//
//  TimerView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject private var model: TimerVM
    @State private var showModal: Bool = false
    @Binding var selectedIndex: Int
    @Binding var to: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                if model.isPaused == model.isRunning {
                    ZStack { PickerView() }.frame(height: 280)
                } else if model.isPaused != model.isRunning {
                    ZStack {
                        ProgressBar()
                    }.frame(height: 280)
                }
                
                HStack {
                    Button(action: {
                        model.stopTimer()
                    }) {
                        TimerButton(style: TimerButton.ButtonStyle.cancel)
                    }.disabled(model.disabledAction())
                        .onDisappear { model.stopTimer() }
                    
                    Spacer()
                    
                    if model.isPaused == model.isRunning {
                        Button(action: { model.startTimer() }, label: {
                            TimerButton(style: TimerButton.ButtonStyle.start)
                        })
                    } else if model.isPaused == false {
                        Button(action: { model.pauseTimer() }, label: {
                            TimerButton(style: TimerButton.ButtonStyle.pause)
                        })
                    } else if model.isRunning == false {
                        Button(action: { model.resumeTimer() }, label: {
                            TimerButton(style: TimerButton.ButtonStyle.resume)
                        })
                    }
                }.padding(.horizontal)
                
                
                
            }
        }.onReceive(model.timer) { (time) in model.receiveTimerUpdate() }
        .preferredColorScheme(.dark)
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(selectedIndex: .constant(0), to: .constant(0.0))
            .environmentObject(TimerVM())
    }
}
