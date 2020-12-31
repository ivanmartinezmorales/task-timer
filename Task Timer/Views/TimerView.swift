//
//  Timerview.swift
//  Task Timer
//
//  Created by Ivan Martinez Morales on 12/29/20.
//

import SwiftUI

enum FocusMode {
    case focusing
    case resting
    
}

struct TimerView: View {
    @State var progressValue: Float = 0.1
    @State var timerRunning: Bool = false
    @State var defaultValue: Int = 25
    @State var focusMode: FocusMode = .focusing
    
    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                    .opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title
                    if focusMode == .focusing {
                        Text("Focus Time")
                            .font(.largeTitle)
                            .bold()
                    } else {
                        Text("Break Time")
                            .font(.largeTitle)
                            .bold()
                    }
                    // Time
                    
                    
                    // Timer selector
                    

                    PlayButton(isPlaying: self.$timerRunning)
                        .frame(width: 80, height: 80)
                        .onTapGesture(perform: {
                            self.timerRunning.toggle()
                        })
                    TimerSelector(timeValue: self.$defaultValue)
                        .frame(width: 80, height: 80)
                    
                }
                
            }
        }
    }
}

struct ProgressCircle: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: isPlaying ? "play.circle" : "pause.circle")
                .resizable()
        }
    }
}

struct TimerSelector: View {
    @Binding var timeValue: Int
    var body: some View {
        ZStack(alignment: .center) {
            Stepper(" ", value: self.$timeValue)
        }
        Text("\(self.timeValue)")
    }
}

struct Timerview_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
