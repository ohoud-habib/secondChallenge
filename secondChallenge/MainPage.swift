import SwiftUI

struct MainPage: View {
    @State private var reminders: [Reminder] = [] // Store reminders

    var body: some View {
        NavigationView {
            VStack {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 160.0)
                    .padding(.trailing, 170.0)
                    .offset(x: -7, y: -40.55)

                Image("plant") // Make sure you have a "plant" image in your assets
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .offset(x: 0, y: -70.55)

                Text("Start your plant journey!")
                    .font(.custom("SFPro", size: 25))
                    .offset(x: 0, y: -40.55)

                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                    .font(.custom("SFPro", size: 16))
                    .foregroundColor(Color(red: 0.623529, green: 0.623529, blue: 0.568627))
                    .multilineTextAlignment(.center)
                    .offset(x: 0, y: -20.55)

                NavigationLink(destination: SetReminder()) {
                    Text("Set Plant Reminder")
                        .font(.custom("SFProRounded-Bold", size: 18))
                        .foregroundColor(Color.black)
                        .frame(width: 280, height: 40)
                        .padding()
                        .background(Color(red: 0.156863, green: 0.878431, blue: 0.658823))
                        .cornerRadius(10)
                        .font(.headline)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    MainPage()
}
