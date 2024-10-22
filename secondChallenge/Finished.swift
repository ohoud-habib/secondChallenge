//
//  Finished.swift
//  secondChallenge
//
//  Created by ohoud on 18/04/1446 AH.
//

import SwiftUI

struct Finished: View {
    @Binding var showsheet: Bool
    
    var body: some View {
        NavigationView {
            
        
        VStack {
            
            
            Image("blinkplant")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("All Done! 🎉 ")
                .font(.custom("SFPro", size: 25))
                .padding(.bottom)
            
            Text("All Reminders Completed")
                .font(.custom("SFPro", size: 16))
                .foregroundColor(Color(red: 0.6235294117647059, green: 0.6235294117647059, blue: 0.5686274509803921))
                .multilineTextAlignment(.center)
            
            Button(action: {
                showsheet.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Reminder")
                }
               
            }
            .padding(.top, 240.0)
            .padding(.trailing,240 )
            
            
        }
        .navigationTitle("My Plants 🌱")
     }
    }
}

#Preview {
    SetReminder()
}
