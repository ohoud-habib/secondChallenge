import SwiftUI

struct ReminderForm: View {
    @Binding var reminders: [Reminder]
    @Binding var isPresented: Bool
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full Sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    @State private var plantName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    HStack {
                        Text("Plant Name")
                        Divider()
                            .frame(width: 2, height: 30)
                            .overlay(Color.green)
                        TextField("Pothos", text: $plantName)
                            .autocapitalization(.words)
                    }
                }

                Section(header: Text("")) {
                    HStack {
                        Image(systemName: "location")
                        Picker("Room", selection: $selectedRoom) {
                            Text("Bedroom").tag("Bedroom")
                            Text("Kitchen").tag("Kitchen")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "sun.max")
                        Picker("Light", selection: $selectedLight) {
                            Text("Full Sun").tag("Full Sun")
                            Text("Partial Sun").tag("Partial Sun")
                            Text("Low Light").tag("Low Light")
                        }
                    }
                }
                    HStack {
                        Image(systemName: "drop")
                        Picker("Watering Days", selection: $selectedWateringDays) {
                            Text("Every day").tag("Every day")
                            Text("Every 2 days").tag("Every 2 days")
                            Text("Every 3 days").tag("Every 3 days")
                            Text("Once a week").tag("Once a week")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "drop")
                        Picker("Water Amount", selection: $selectedWaterAmount) {
                            Text("20-50 ml").tag("20-50 ml")
                            Text("50-100 ml").tag("50-100 ml")
                            Text("100-200 ml").tag("100-200 ml")
                        }
                    }
                
            }
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .navigationBarTitle("Set Reminder", displayMode: .inline)
        }
    }

    private var cancelButton: some View {
        Button("Cancel") {
            isPresented.toggle()
        }
        .foregroundColor(Color.trq)
    }

    private var saveButton: some View {
        Button("Save") {
            let reminderText = "Plant: \(plantName), Room: \(selectedRoom), Light: \(selectedLight), Watering Days: \(selectedWateringDays), Water Amount: \(selectedWaterAmount)"
            
            reminders.append(Reminder(text: reminderText, isChecked: false))
            resetForm()
            isPresented.toggle() // Dismiss the form
        }
        .foregroundColor(Color.trq)
        .disabled(plantName.isEmpty)
        .opacity(plantName.isEmpty ? 0.5 : 1.0)
    }

    private func resetForm() {
        selectedRoom = "Bedroom"
        selectedLight = "Full Sun"
        selectedWateringDays = "Every day"
        selectedWaterAmount = "20-50 ml"
        plantName = ""
    }
}

#Preview {
    ReminderForm(reminders: .constant([]), isPresented: .constant(true))
}
