//
//  TimerModel.swift
//  FocusPocus
//
//  Created by Enrico Madonna on 08/02/24.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    
    enum stopWatchMode {
        case running
        case stopped
    }
    
    @Published var mode: stopWatchMode = .stopped
    @Published var focusTime = 0.0 //random time
    @Published var focusTimeStart = 4.0 //
    @Published var focusTimeEnd = 12.0 //
    
    @Published var userScore = 0
    @Published var timerFinished: Bool = false
    
    @Published var secondsElapsed = 0.0
    @Published var record = 0.0
    @Published var win = false
    @Published var isPlaying = false
    var timer = Timer()
    
    func start() {
        mode = .running
        createFocusTime()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.secondsElapsed += 0.1
            if self.secondsElapsed>=(self.focusTime+1) && self.timerFinished==false{
                self.timerFinished=true
                print("timerFinished=true")
            
                
            }
         
        }
    }
    func createFocusTime(){
        focusTime = Double.random(in: focusTimeStart...focusTimeEnd)
        
    }
    func restartFocusTime(){
        focusTimeStart = 4.0
        focusTimeEnd = 12.0
    }
    
    

    
    func stop() {
        timer.invalidate()
        self.isPlaying=false
        record=secondsElapsed
        secondsElapsed = 0
        userScore = 0
        focusTime=0
        restartFocusTime()
        mode = .stopped
        self.timerFinished=false
        
    }
}
