import SwiftUI
struct MainPage: View {
    @Binding var remindersheet: Bool

    var body: some View {
        VStack {
            Divider()
                .overlay(Color.gray)
                .offset(x: 0, y: -130.55)

            Image("plant")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .offset(x: 0, y: -70.55)

            Text("Start your plant journey!")
                .font(.custom("SFPro", size: 25))
                .offset(x: 0, y: -40.55)

            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                .font(.custom("SFPro", size: 16))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .offset(x: 0, y: -20.55)

            Button(action: {
                remindersheet.toggle()
            }) {
                Text("Set Plant Reminder")
                    .font(.headline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 70)
                    .foregroundColor(.black)
                    .background(Color("trq"))
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("My Plants 🌱")
    }
}

#Preview {
    MainPage(remindersheet: .constant(false))
}
