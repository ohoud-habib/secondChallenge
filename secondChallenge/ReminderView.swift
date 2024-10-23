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

                // Extract room and watering days for top components
                let roomComponent = components.first(where: { $0.contains("Room:") })
                let wateringDaysComponent = components.first(where: { $0.contains("Watering Days:") })

                // Display room and watering days side by side
                HStack {
                    if let room = roomComponent {
                        let (icon, value, textColor) = getComponentValue(for: room)
                        HStack(spacing: 2) {
                            Image(systemName: icon)
                                .foregroundColor(textColor)
                            Text(value)
                                .foregroundColor(textColor)
                        }
                    }

                    if let wateringDays = wateringDaysComponent {
                        let (icon, value, textColor) = getComponentValue(for: wateringDays)
                        HStack(spacing: 2) {
                            Image(systemName: icon)
                                .foregroundColor(textColor)
                            Text(value)
                                .foregroundColor(textColor)
                        }
                    }
                }

                // Extract the plant name for the title
                if let plantComponent = components.first(where: { $0.contains("Plant:") }) {
                    let plantName = plantComponent.replacingOccurrences(of: "Plant: ", with: "")
                    Text(plantName)
                        .font(.largeTitle) // Title font size
                        .foregroundColor(plantTextColor)
                }

                // Extract light and water amount for bottom components
                let lightComponent = components.first(where: { $0.contains("Light:") })
                let waterAmountComponent = components.first(where: { $0.contains("Water Amount:") })

                // Display light and water amount in adjacent grey rectangles
                HStack(spacing: 10) { // Adjust spacing as needed
                    if let light = lightComponent {
                        let (icon, value, textColor) = getComponentValue(for: light)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 100, height: 30) // Adjust width and height for smaller size
                            HStack(spacing: 2) {
                                Image(systemName: icon)
                                    .foregroundColor(textColor)
                                Text(value)
                                    .foregroundColor(textColor)
                            }
                        }
                    }

                    if let waterAmount = waterAmountComponent {
                        let (icon, value, textColor) = getComponentValue(for: waterAmount)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 100, height: 30) // Adjust width and height for smaller size
                            HStack(spacing: 2) {
                                Image(systemName: icon)
                                    .foregroundColor(textColor)
                                Text(value)
                                    .foregroundColor(textColor)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 5)
        }
    }

    // Function to return icon, selected value, and text color based on the component type
    private func getComponentValue(for component: String) -> (String, String, Color) {
        if component.contains("Room:") {
            return ("location", component.replacingOccurrences(of: "Room: ", with: ""), roomTextColor) // Return room
        } else if component.contains("Light:") {
            return ("sun.max", component.replacingOccurrences(of: "Light: ", with: ""), lightTextColor) // Return light
        } else if component.contains("Watering Days:") {
            return ("drop", component.replacingOccurrences(of: "Watering Days: ", with: ""), wateringDaysTextColor) // Return watering days
        } else if component.contains("Water Amount:") {
            return ("drop", component.replacingOccurrences(of: "Water Amount: ", with: ""), waterAmountTextColor) // Return water amount
        } else {
            return ("questionmark", component, .gray) // Default case
        }
    }
}

#Preview {
    ReminderView(reminder: Reminder(text: "Plant: Pothos, Room: Bedroom, Light: Full Sun, Watering Days: Every day, Water Amount: 20-50 ml", isChecked: false), toggleAction: {})
}
