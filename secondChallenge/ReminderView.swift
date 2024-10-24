import SwiftUI

struct Reminder: Identifiable {
    let id = UUID()
    var text: String
    var isChecked: Bool
}

struct ReminderView: View {
    var reminder: Reminder
    var toggleAction: () -> Void

    // Define colors for each component
    var plantTextColor: Color = .white
    var roomTextColor: Color = .gray
    var lightTextColor: Color = .yell
    var wateringDaysTextColor: Color = .orange
    var waterAmountTextColor: Color = .babyBlue

    var body: some View {
        HStack {
            Button(action: toggleAction) {
                Image(systemName: reminder.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(reminder.isChecked ? .green : .primary)
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading) {
                let components = reminder.text.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }

                // Display room and watering days
                HStack {
                    displayComponent(components, for: "Room:", icon: "location", textColor: roomTextColor)
                    displayComponent(components, for: "Watering Days:", icon: "drop", textColor: wateringDaysTextColor)
                }

                // Display plant name
                if let plantName = getValue(for: "Plant:", from: components) {
                    Text(plantName)
                        .font(.largeTitle)
                        .foregroundColor(plantTextColor)
                }

                // Display light and water amount
                HStack(spacing: 10) {
                    displayComponent(components, for: "Light:", icon: "sun.max", textColor: lightTextColor)
                    displayComponent(components, for: "Water Amount:", icon: "drop", textColor: waterAmountTextColor)
                }
            }
            .padding(.vertical, 5)
        }
    }

    // Helper function to display components
    private func displayComponent(_ components: [String], for key: String, icon: String, textColor: Color) -> some View {
        if let value = getValue(for: key, from: components) {
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 30)
                    HStack(spacing: 2) {
                        Image(systemName: icon)
                            .foregroundColor(textColor)
                        Text(value)
                            .foregroundColor(textColor)
                    }
                }
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
    ReminderView(reminder: Reminder(text: "Plant: Pothos, Room: Bedroom, Light: Full Sun, Watering Days: Every day, Water Amount: 20-50 ml", isChecked: false), toggleAction: {})
}
