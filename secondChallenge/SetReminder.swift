import SwiftUI


struct Reminder: Identifiable {
    let id = UUID()
    var text: String
    var isChecked: Bool
}

struct ReminderView: View {
    var reminder: Reminder
    var toggleAction: () -> Void

    private let colorMapping: [String: Color] = [
        "Room": Color.blue.opacity(0.3),
        "Plant": Color.green.opacity(0.3),
        "Light": Color.yellow.opacity(0.3),
        "Watering Days": Color.orange.opacity(0.3),
        "Water Amount": Color.purple.opacity(0.3)
    ]
    
    var body: some View {
        HStack {
            Button(action: toggleAction) {
                Image(systemName: reminder.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(reminder.isChecked ? .green : .primary)
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading) {
                let components = reminder.text.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                
                
                ForEach(components, id: \.self) { component in
                    HStack {
                        if component.contains("Room:") {
                            HStack{
                                Image(systemName: "location")
                                Text(component)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(10)
                            }
                            
                        }else if component.contains("Plant:") {
                                HStack{
                                    Image(systemName: "location")
                                    Text(component)
                                        .padding()
                                        .background(Color(.systemGray5))
                                        .cornerRadius(10)
                                    
                                }
                            
                        } else if component.contains("Light:") {
                            Image(systemName: "sun.max")
                            Text(component)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                             
                        } else if component.contains("Watering Days:") {
                            Image(systemName: "drop")
                            Text(component)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                                
                        } else if component.contains("Water Amount:") {
                            Image(systemName: "drop")
                            Text(component)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(10)
                            
                        } else {
                            Text(component)
                        }
                    }
                }
            }
            .padding(.vertical, 5)
        }
    }
}

struct SetReminder: View {
    @State private var reminders: [Reminder] = []
    @State var showsheet = false

    // State variables for the selection menus with default values
    @State private var selectedRoom: String? = "Bedroom"
    @State private var selectedLight: String? = "Full Sun"
    @State private var selectedWateringDays: String? = "Every day"
    @State private var selectedWaterAmount: String? = "20-50 ml"
    @State private var plantName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                if reminders.isEmpty {
                    Finished(showsheet: $showsheet)
                } else {
                    List {
                        ForEach(reminders) { reminder in
                            ReminderView(reminder: reminder) {
                                if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                    reminders[index].isChecked.toggle()
                                }
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
//                        .frame(minWidth: .infinity, maxWidth: .infinity, alignment: .leading)
//                        .padding(.bottom,1)
                    }
                    .padding(.bottom, 20)
                }
            }
            .sheet(isPresented: $showsheet) {
                NavigationView {
                    Form {
                        Section(header: Text(" ")) {
                            HStack {
                                Text("Plant Name")
                                Divider()
                                    .frame(width: 2, height: 30)
                                    .overlay(Color("trq"))
                                TextField("Pothos", text: $plantName)
                            }
                        }

                        Section(header: Text(" ")) {
                            HStack {
                                Image(systemName: "location")
                                Picker("Room", selection: $selectedRoom) {
                                    Text("Bedroom").tag("Bedroom" as String?)
                                    Text("Kitchen").tag("Kitchen" as String?)
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            
                            HStack {
                                Image(systemName: "sun.max")
                                Picker("Light", selection: $selectedLight) {
                                    Text("Full Sun").tag("Full Sun" as String?)
                                    Text("Partial Sun").tag("Partial Sun" as String?)
                                    Text("Low Light").tag("Low Light" as String?)
                                    
                                }
                                .pickerStyle(MenuPickerStyle())
                               
                            }
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                            Picker("Watering Days", selection: $selectedWateringDays) {
                                Text("Every day").tag("Every day" as String?)
                                Text("Every 2 days").tag("Every 2 days" as String?)
                                Text("Every 3 days").tag("Every 3 days" as String?)
                                Text("Once a week").tag("Once a week" as String?)
                                Text("Every 10 days").tag("Every 10 days" as String?)
                                Text("Every 2 weeks").tag("Every 2 weeks" as String?)
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        HStack {
                            Image(systemName: "drop")
                            Picker("Water Amount", selection: $selectedWaterAmount) {
                                Text("20-50 ml").tag("20-50 ml" as String?)
                                Text("50-100 ml").tag("50-100 ml" as String?)
                                Text("100-200 ml").tag("100-200 ml" as String?)
                                Text("200-300 ml").tag("200-300 ml" as String?)
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    .navigationBarItems(leading: Button("Cancel") {
                        showsheet.toggle() // Dismiss the sheet
                    }, trailing: Button("Save") {
                        let reminderText = "Plant: \(plantName), Room: \(selectedRoom ?? "N/A"), Light: \(selectedLight ?? "N/A"), Watering Days: \(selectedWateringDays ?? "N/A"), Water Amount: \(selectedWaterAmount ?? "N/A")"
                        let newReminder = Reminder(text: reminderText, isChecked: false)
                        reminders.append(newReminder)

                        // Reset to default
                        selectedRoom = "Bedroom"
                        selectedLight = "Full Sun"
                        selectedWateringDays = "Every day"
                        selectedWaterAmount = "20-50 ml"
                        plantName = "" // Reset plant name

                        showsheet.toggle()
                    })
                    .navigationBarTitle(Text("Set Reminder"), displayMode: .inline)
                }
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
}

#Preview {
    SetReminder()
}
