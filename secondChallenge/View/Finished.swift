import SwiftUI

struct Finished: View {
    @Binding var remindersheet: Bool

    var body: some View {
        VStack {
            Text("My Plants 🌱")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(x: -80, y: 40.55)
            Divider()
            .overlay(Color.gray)
            .offset(x: 0, y: 25.55)
            Image("blinkplant") 
                .imageScale(.large)
                .foregroundStyle(.tint)
                .offset(x: 0, y: 150.55)

            Text("All Done! 🎉 ")
                .font(.custom("SFPro", size: 25))
                .padding(.bottom)
                .offset(x: 0, y: 150.55)

            Text("All Reminders Completed")
                .font(.custom("SFPro", size: 16))
                .foregroundColor(Color(red: 0.623529, green: 0.623529, blue: 0.568627))
                .multilineTextAlignment(.leading)
                .offset(x: -9, y: 140.55)

            Button(action: {
                remindersheet.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.trq)
                    Text("Add Reminder")
                        .foregroundColor(Color.trq)
                }
            }
            .padding(.top, 360.0)
            .padding(.trailing, 240)
        }
        .navigationBarBackButtonHidden(true)
     
    }
}

#Preview {
    Finished(remindersheet: .constant(false))
}
