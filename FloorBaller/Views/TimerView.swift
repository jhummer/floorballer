//
//  TimerView.swift
//  FloorBaller
//
//  Created by Joakim Hummer on 2023-02-06.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    // TODO: auto-toggle finished game when timer finished
    
    @State var countdownTime = 60 * 5 /// default to 300 seconds (5 mins)
    @State private var isRunning = false

    var minutes: Int {
        countdownTime / 60
    }

    var seconds: Int {
        countdownTime % 60
    }

    /// setup a Timer
    @State private var timer: Timer?

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                StopwatchUnit(timeUnit: minutes, timeUnitText: "MIN", color: .blue)
                Text(":")
                    .font(.system(size: 48))
                    .offset(y: -18)
                StopwatchUnit(timeUnit: seconds, timeUnitText: "SEC", color: .green)
            }

            HStack {
                Button(action: {
                    if isRunning{
                        timer?.invalidate()
                        playSound()
                    } else {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            countdownTime -= 1
                        })
                    }
                    isRunning.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 120, height: 50, alignment: .center)
                            .foregroundColor(isRunning ? .pink : .green)

                        Text(isRunning ? "Stop" : "Start")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    countdownTime = 0
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 120, height: 50, alignment: .center)
                            .foregroundColor(.gray)

                        Text("Reset")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


struct StopwatchUnit: View {

    var timeUnit: Int
    var timeUnitText: String
    var color: Color

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10.
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .fill(color)
                    .frame(width: 75, height: 75, alignment: .center)

                HStack(spacing: 2) {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 48))
                        .frame(width: 28)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 48))
                        .frame(width: 28)
                }
            }

            Text(timeUnitText)
                .font(.system(size: 16))
        }
    }
}

func playSound() {
    // AudioServicesPlaySystemSound(1304) // minute warning
    AudioServicesPlaySystemSound(1023) // 1023 - tågtuta
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}


