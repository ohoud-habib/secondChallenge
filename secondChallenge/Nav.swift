import SwiftUI

// Define a structure for a Reminder
struct Reminder: Identifiable {
    let id = UUID()
    var text: String
    var isChecked: Bool
}

struct Nav: View {
    @State private var reminders: [Reminder] = []
    @State private var showsheet = false

    // State variables for the selection menus with default values
    @State private var selectedRoom: String? = "Bedroom"
    @State private var selectedLight: String? = "Full Sun"
    @State private var selectedWateringDays: String? = "Every day"
    @State private var selectedWaterAmount: String? = "20-50 ml"

    var body: some View {
        NavigationView {
            VStack {
                if reminders.isEmpty {
                    Finisheda(showsheet: $showsheet)
                } else {
                    List {
                        ForEach(reminders) { reminder in
                            HStack {
                                Button(action: {
                                    if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                        reminders[index].isChecked.toggle()
                                    }
                                }) {
                                    Image(systemName: reminder.isChecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(reminder.isChecked ? .green : .primary)
                                }
                                Text(reminder.text)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationTitle("My Plants 🌱")

                    Spacer()

                    Button(action: {
                        showsheet.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                        .padding()
                    }
                    .padding(.bottom, 20)
                }
            }
            .sheet(isPresented: $showsheet) {
                NavigationView {
                    Form {
                        Section(header: Text("")) {
                            Picker("Room", selection: $selectedRoom) {
                                Text("Select a room").tag(nil as String?)
                                Text("Bedroom").tag("Bedroom" as String?)
                                Text("Kitchen").tag("Kitchen" as String?)
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            Picker("Light", selection: $selectedLight) {
                                Text("Select light").tag(nil as String?)
                                Text("Full Sun").tag("Full Sun" as String?)
                                Text("Partial Sun").tag("Partial Sun" as String?)
                                Text("Low Light").tag("Low Light" as String?)
                            }
                        }
                            .pickerStyle(MenuPickerStyle())

                            Picker("Watering Days", selection: $selectedWateringDays) {
                                Text("Select watering days").tag(nil as String?)
                                Text("Every day").tag("Every day" as String?)
                                Text("Every 2 days").tag("Every 2 days" as String?)
                                Text("Every 3 days").tag("Every 3 days" as String?)
                                Text("Once a week").tag("Once a week" as String?)
                                Text("Every 10 days").tag("Every 10 days" as String?)
                                Text("Every 2 weeks").tag("Every 2 weeks" as String?)
                            }
                            .pickerStyle(MenuPickerStyle())

                            Picker("Water Amount", selection: $selectedWaterAmount) {
                                Text("Select water amount").tag(nil as String?)
                                Text("20-50 ml").tag("20-50 ml" as String?)
                                Text("50-100 ml").tag("50-100 ml" as String?)
                                Text("100-200 ml").tag("100-200 ml" as String?)
                                Text("200-300 ml").tag("200-300 ml" as String?)
                            }
                            .pickerStyle(MenuPickerStyle())
                        
                    }
                    .navigationTitle("Set Reminder")
                    .navigationBarItems(leading: Button("Cancel") {
                        showsheet.toggle() // Dismiss the sheet
                    }, trailing: Button("Save") {
                        let reminderText = "Room: \(selectedRoom ?? "N/A"), Light: \(selectedLight ?? "N/A"), Watering Days: \(selectedWateringDays ?? "N/A"), Water Amount: \(selectedWaterAmount ?? "N/A")"
                        let newReminder = Reminder(text: reminderText, isChecked: false)
                        reminders.append(newReminder) // Save the reminder to the list
                        
                        // Reset selections to default values
                        selectedRoom = "Bedroom"
                        selectedLight = "Full Sun"
                        selectedWateringDays = "Every day"
                        selectedWaterAmount = "20-50 ml"
                        
                        showsheet.toggle() // Dismiss the sheet
                    })
                }
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
}

struct Finisheda: View {
    @Binding var showsheet: Bool
    
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
            
            Button(action: {
                showsheet.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Reminder")
                }
                .padding()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    Nav()
}
