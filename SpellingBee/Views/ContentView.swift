//
//  ContentView.swift
//  SpellingBee
//
//  Created by Russell Gordon on 2022-02-16.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State var currentItem = itemsToSpell.randomElement()!
    @State var inputGiven = ""
    @State var answerChecked = false
    @State var answerCorrect = false
    
    // MARK: Computed properties
    // Correct Answer
    var correctSpelling: String {
        return currentItem.word
    }
    var body: some View {
        
        VStack {
            
            Image(currentItem.imageName)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    
                    // Create the word to be spoken (an utterance) and set
                    // characteristics of how the voice will sound
                    let utterance = AVSpeechUtterance(string: currentItem.word)
                    
                    // See a list of available language codes and their corresponding
                    // voice names and genders here:
                    // https://www.ikiapps.com/tips/2015/12/30/setting-voice-for-tts-in-ios
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                    
                    // How fast the utterance will be spoken
                    utterance.rate = 0.5
                    
                    // Synthesize (speak) the utterance
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
                    
                }
            
            TextField("Enter your answer🐝",
                      text: $inputGiven)
                .padding(.horizontal, 30)
                .foregroundColor(Color.yellow)
                .accentColor(.yellow)
                .font(.custom("Courier New", size: 30).bold())
                .multilineTextAlignment(TextAlignment.center)
                .autocapitalization(.none)
            
            
            // Check Button
            Button(action: {
                
                // Answer has been checked!
                answerChecked = true
                
                // Check the answer!
                if inputGiven == correctSpelling {
                    answerCorrect = true
                } else {
                    answerCorrect = false
                }
            }, label: {
                Text("Check Answer")
                    .font(.body)
                    .foregroundColor(Color.black)
            })
                .buttonStyle(.bordered)
            
            ZStack {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.green)
                //        CONDITION      true  false
                    .opacity(answerCorrect == true ? 1.0 : 0.0)
                
                Image(systemName: "x.square")
                    .foregroundColor(.red)
                //        CONDITION1         AND     CONDITION2         true  false
                //       answerChecked = true     answerCorrect = false
                    .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
            }
            .font(.system(size: 40))
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
