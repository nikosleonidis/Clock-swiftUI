//
//  PickerView.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI

struct PickerView: View {
    
    @AppStorage("SelectedPicker") var selectedPicker = ""
    @EnvironmentObject private var model: TimerVM
    
    var hours = [Int](0...23)
    var minutes = [Int](0...59)
    var seconds = [Int](0...59)
    
    var body: some View {
        DurationPicker(duration: .constant(TimeInterval(0.0)))
    }
}

struct DurationPicker: UIViewRepresentable {
    @Binding var duration: TimeInterval

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.countDownDuration = duration
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(DurationPicker(duration: .constant(TimeInterval(0.0))))
    }

    class Coordinator: NSObject {
        let parent: DurationPicker

        init(_ parent: DurationPicker) {
            self.parent = parent
        }

        @objc func updateDuration(datePicker: UIDatePicker) {
            parent.duration = datePicker.countDownDuration
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView().environmentObject(TimerVM())
    }
}

//extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return userRoles.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        userRoles\[row\]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedIndex = row
//        buttonRole.setTitle(userRoles\[row\], for: .normal)
//    }
//}

//        GeometryReader { geometry in
//            HStack {
//                Picker("SelectedPicker", selection: $model.selectedHours.onChange(model.updateTimer)) {
//                    ForEach(hours, id: \.self) { hour in
//                        Text("\(hour)").tag(hours)
//                    }
//                }.pickerStyle(.wheel)
//                .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center)
//                .compositingGroup()
//                .clipped()
//
//                Picker("SelectedPicker", selection: $model.selectedMinutes.onChange(model.updateTimer)) {
//                    ForEach(minutes, id: \.self) { minute in
//                        Text("\(minute)").tag(minutes)
//                    }
//                }.pickerStyle(.wheel)
//                .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center)
//                .compositingGroup()
//                .clipped()
//
//                Picker("SelectedPicker", selection: $model.selectedSeconds.onChange(model.updateTimer)) {
//                    ForEach(seconds, id: \.self) { second in
//                        Text("\(second)").tag(seconds)
//                    }
//                }.pickerStyle(.wheel)
//                .frame(width: geometry.size.width/3, height: geometry.size.height, alignment: .center)
//                .compositingGroup()
//                .clipped()
//            }.padding(.horizontal, 30)
//        }
