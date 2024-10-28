import SwiftUI

struct ReminderView: View {
    var reminder: Reminder
    var toggleAction: () -> Void
    var editAction: () -> Void
    // each component color
    var plantTextColor: Color = .white
    var roomTextColor: Color = .gray
    var lightTextColor: Color = .yell
    var wateringDaysTextColor: Color = .orange
    var waterAmountTextColor: Color = .babyBlue

    var body: some View {
    
        HStack {
            Button(action: toggleAction) {
                Image(systemName: reminder.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(reminder.isChecked ? .purple : .primary)
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading) {
                let components = reminder.text.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

                HStack {
                    displayComponent(components, for: "Room:", icon: "location", textColor: roomTextColor)
                    displayComponent(components, for: "Watering Days:", icon: "drop", textColor: wateringDaysTextColor)
                }
                
                if let plantName = getValue(for: "Plant:", from: components) {
                    Text(plantName)
                        .font(.title)
                        .foregroundColor(plantTextColor)
                }
                
                HStack(spacing: 4) {
                    displayComponent(components, for: "Light:", icon: "sun.max", textColor: lightTextColor)
                    displayComponent(components, for: "Water Amount:", icon: "drop", textColor: waterAmountTextColor)
                }
            }
            .padding(.vertical, 5)

           
            Button(action: editAction) {
                Text("")
                    .foregroundColor(.trq)
                    .padding(5)
                    .cornerRadius(5)
            }
        }
        .padding()
        .cornerRadius(8)
    }

   
    private func displayComponent(_ components: [String], for key: String, icon: String, textColor: Color) -> some View {
        if let value = getValue(for: key, from: components) {
            return AnyView(
                HStack(spacing: 4) {
                    Image(systemName: icon)
                        .foregroundColor(textColor)
                    Text(value)
                        .foregroundColor(textColor)
                }
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
            )
        }
        return AnyView(EmptyView())
    }

    // Function to extract value for a given key
    private func getValue(for key: String, from components: [String]) -> String? {
        components.first { $0.contains(key) }?.replacingOccurrences(of: "\(key) ", with: "")
    }
}

#Preview {
    ReminderView(reminder: Reminder(text: "Plant: Pothos, Room: Bedroom, Light: Full Sun, Watering Days: Every day, Water Amount: 20-50 ml", isChecked: false), toggleAction: {}, editAction: {})
}
