//
//  ButtonView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import Foundation
import SwiftUI

let colorButtonGreen = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.1956502144)
let colorButtonOrange = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.1546618734)

struct TimerButton: View {
    enum ButtonStyle {
        case start
        case pause
        case resume
        case cancel
        
        var title: String {
            switch self {
            case .start:
                return "Start"
            case .pause:
                return "Pause"
            case .resume:
                return "Resume"
            case .cancel:
                return "Cancel"
            }
        }
        
        var fillColor: Color {
            switch self {
            case .start:
                    return Color(colorButtonGreen)
            case .pause:
                return Color(colorButtonOrange)
            case .resume:
                    return Color(colorButtonGreen)
            case .cancel:
                return Color(.secondarySystemBackground)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .start:
                    return Color(.systemGreen)
            case .pause:
                    return Color(.systemOrange)
            case .resume:
                    return Color(.systemGreen)
            case .cancel:
                    return Color(.systemGray)
            }
        }
    }
    
    var style: ButtonStyle
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style.fillColor, lineWidth: 2)
                .frame(width: 70, height: 70)
            
            Circle()
                .fill(style.fillColor)
                .frame(width: 65, height: 65)
                .overlay(
                    Text(style.title)
                        .font(.subheadline)
                        .foregroundColor(style.foregroundColor)
                )
        }
    }
}
