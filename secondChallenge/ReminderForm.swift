import SwiftUI

struct ReminderForm: View {
    @Binding var reminders: [Reminder]
    @Binding var isPresented: Bool
    @Binding var editingReminder: Reminder?
    
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full Sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    @State private var plantName: String = ""

    var body: some View {
        NavigationView {
            Form {
                // reminder details
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
            //navigation Bar Items
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .navigationBarTitle(editingReminder == nil ? "Set Reminder" : "Edit Reminder", displayMode: .inline)
            // edit reminder
            .onAppear {
                if let reminder = editingReminder {
                    populateFields(from: reminder)
                }
            }
        }
    }
        
    private var cancelButton: some View {
        Button("Cancel") {
            isPresented.toggle()
            editingReminder = nil // Reset editing reminder on cancel
        }
        .foregroundColor(Color.trq)
    }
    

    private var saveButton: some View {
        Button("Save") {
            let reminderText = "Plant: \(plantName), Room: \(selectedRoom), Light: \(selectedLight), Watering Days: \(selectedWateringDays), Water Amount: \(selectedWaterAmount)"
            
            if let editingReminder = editingReminder {
                // Update existing reminder
                if let index = reminders.firstIndex(where: { $0.id == editingReminder.id }) {
                    reminders[index].text = reminderText
                }
            } else {
                // Add new reminder
                reminders.append(Reminder(text: reminderText, isChecked: false))
            }

            resetForm()
            isPresented.toggle() // get out of the form
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
    
    private func populateFields(from reminder: Reminder) {
        let components = reminder.text.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        plantName = getValue(for: "Plant:", from: components) ?? ""
        selectedRoom = getValue(for: "Room:", from: components) ?? "Bedroom"
        selectedLight = getValue(for: "Light:", from: components) ?? "Full Sun"
        selectedWateringDays = getValue(for: "Watering Days:", from: components) ?? "Every day"
        selectedWaterAmount = getValue(for: "Water Amount:", from: components) ?? "20-50 ml"
    }

    // Function to extract value for a given key
    private func getValue(for key: String, from components: [String]) -> String? {
        components.first { $0.contains(key) }?.replacingOccurrences(of: "\(key) ", with: "")
    }
}

#Preview {
    ReminderForm(reminders: .constant([]), isPresented: .constant(true), editingReminder: .constant(nil))
}
