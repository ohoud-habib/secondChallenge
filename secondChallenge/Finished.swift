//
//  Finished.swift
//  secondChallenge
//
//  Created by ohoud on 18/04/1446 AH.
//

import SwiftUI

struct Finished: View {
   

    var body: some View {
       
        VStack {
            
            Text("My Plants 🌱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(x: -86, y: -170)
            
            Image("blinkplant")
                .imageScale(.large)
                .foregroundStyle(.tint)
                
                                
            Text("All Done! 🎉 ")
                .font(.custom("SFPro", size: 25))
            
            Text("All Reminders Completed")
                .font(.custom("SFPro", size: 16))
                .foregroundColor(Color(red: 0.6235294117647059, green: 0.6235294117647059, blue: 0.5686274509803921))
                .multilineTextAlignment(.center)
            
            
        }
    }
   
}

#Preview {
    Finished()
}
