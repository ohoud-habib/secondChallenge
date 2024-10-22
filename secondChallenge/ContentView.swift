//
//  ContentView.swift
//  secondChallenge
//
//  Created by ohoud on 17/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      
        
            
            
            VStack {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 160.0)
                    .padding(.trailing, 170.0)
                    .offset(x: -7, y: -40.55)
                
                Image("plant")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .offset(x: 0, y: -70.55)
                                    
                Text("Start your plant journey! ")
                    .font(.custom("SFPro", size: 25))                    .offset(x: 0, y: -40.55)
                
                   
                
                
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.custom("SFPro", size: 16)) 
                    .foregroundColor(Color(red: 0.6235294117647059, green: 0.6235294117647059, blue: 0.5686274509803921))
                    .multilineTextAlignment(.center)
                    .offset(x: 0, y: -20.55)
                
                
                Button(action: {
                    
                    print("set Plant Reminder Button Pressed")
                }) {
                    Text("Set Plant Reminder")
                        .font(.custom("SFProRounded-Bold", size: 18))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.1568627450980392, green: 0.8784313725490196, blue: 0.6588235294117647))
                        .cornerRadius(10)
                        .font(.headline)
                }
                .padding()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
