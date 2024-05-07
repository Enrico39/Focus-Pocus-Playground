import SwiftUI

struct ContentView: View {
     @ObservedObject var timer = TimerManager()
    
     let randomPhrases = [
        "Well, that could have gone better...",
        "Oops, maybe a little more focus next time?",
        "Looks like we had a concentration slip!",
        "Time to up your focus game!",
        "A little more focus, a little less distraction!",
        "Oops, distracted again. Let's do better next time!"
    ]
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
           
            VStack{
                Button(action: {
                    timer.isPlaying=true
                    self.timer.start()     
                },label: {
                    VStack {
                        Image(systemName: "play")
                            .imageScale(.large)
                            .foregroundColor(.white)
                        Text("Test Your Focus")
                            .foregroundColor(Color.white)  
                            .padding()
                        
                    }
                })
                
                if(timer.record>0 && timer.record<120){
                    Text("Your Last Attention Span: \(String(format: "%.1f", timer.record)) seconds")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding()
                    Text(randomPhrases.randomElement() ?? "") 
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                        .padding()
                }   
                Text("How to Play: Click the circle when it starts blinking red.")
                    .padding(.horizontal,100)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            if timer.isPlaying == true{
                FocusView(timer: timer)
            }
            
            
            if timer.win == true{
                ZStack{
                    Color(.black)
                    VStack{
                        Text("Thanks for Playing!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("You focused for more than 2 minutes!")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("It is undeniable that in recent years there has been a significant decline in people's ability to concentrate, with an increasingly shorter and fragmented average attention span. This phenomenon can be attributed to a variety of factors, including an excess of stimuli from the media and technology, which foster a sort of 'information overload syndrome.' However, it is important to understand that the ability to concentrate is a skill that can be trained and improved with practice and specific strategies, such as mindfulness and time management.")
                            .padding(.horizontal,100)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {timer.win=false
                            timer.isPlaying=false    
                        }, label: {
                            Text("Go Back.")
                                .font(.headline)         
                                .padding()
                        })
                        
                    }
                }
            }
            
        }
    }
}
