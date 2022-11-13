//
//  WorldClockView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI

struct WorldClockView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("World Clock")
            }
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}
