//
//  FocusView.swift
//  FocusPocus
//
//  Created by Enrico Madonna on 08/02/24.
//

import Foundation
import SwiftUI

struct FocusView: View {
    @ObservedObject var timer: TimerManager
    //@Binding var isPlaying: Bool
    @State private var isShowingImage = false

    @State private var rotation: Double = 360
    @State private var isBlinking: Bool = false
     var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
            
                Spacer()
                
                
              /*  Text("\(String(format: "%.1f", timer.secondsElapsed)) seconds")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                Text("press at \(String(format: "%.1f", timer.focusTime))")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                */
                
                if (timer.timerFinished == true){
                
                    Text("you Focused for \(String(format: "%.1f", timer.secondsElapsed)) seconds")
 
                         .font(.system(size: 30))
                        .foregroundColor(.red)
                        .onAppear(perform: {
                            timer.stop()

                        })
                }
      
              
                
            }
      
            
            
            Button(action: {
                
                if (timer.secondsElapsed-timer.focusTime) <= 1.8 && (timer.secondsElapsed-timer.focusTime) >= 0{
                    timer.focusTimeStart=timer.focusTimeEnd+5
                    timer.focusTimeEnd+=9
                    timer.createFocusTime()
                    if timer.secondsElapsed>=(120){
                        timer.win=true
                        timer.stop()
                    }
                }else{
                    timer.stop()
                    rotation = 0
                    
                }
                
                
            }, label: {
                Image(systemName: "circle.dotted.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
                    .imageScale(.large)
                    .foregroundColor(.white)
                
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        animateRotation()
                    }
                
            })
            
            if (timer.secondsElapsed-timer.focusTime) <= 0.8 && (timer.secondsElapsed-timer.focusTime) > 0{
                BlinkingImage()
            }        
   
            
           
          
            
        }
    }
    
    private func animateRotation() {
        withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
            rotation = 0
        }
    }
    
    
    func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            withAnimation {
                self.isShowingImage.toggle()
            }
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView(timer: TimerManager())
    }
}


struct BlinkingImage: View {
    @State private var isShowingImage = false
    
    var body: some View {
        Image(systemName: "circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 140)
            .imageScale(.large)
            .foregroundColor(.red)
            .opacity(isShowingImage ? 1.0 : 0.0)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true) { timer in
                    self.isShowingImage.toggle()
                }
            }
    }
}
