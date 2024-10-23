import SwiftUI



struct SetReminder: View {
    @State private var reminders: [Reminder] = []
    @State var remindersheet = false

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
                    Finished(remindersheet: $remindersheet)
                } else {
                    Text("Today")
                        .font(.title)
                        .foregroundColor(.white)
                        .offset(x: -140, y: 10.55)

                                        Spacer()
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
                        remindersheet.toggle()
                    }) {
                        HStack {
                            
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color.trq)
                            Text("New Reminder")
                                .foregroundColor(Color.trq)
                                
                                
                        }
                       
                    }
                    .padding(.bottom, 10.0)
                    .padding(.trailing,230 )
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $remindersheet) {
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
                                        .foregroundColor(.gray)
                                }
                                .pickerStyle(MenuPickerStyle())
                               
                            }
                        }
                        
                        HStack {
                            Image(systemName: "drop")
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
                        
                        remindersheet.toggle()
                    }.foregroundColor(Color.trq)
                                        , trailing: Button("Save") {
                        let reminderText = "Plant: \(plantName), Room: \(selectedRoom ?? "N/A"), Light: \(selectedLight ?? "N/A"), Watering Days: \(selectedWateringDays ?? "N/A"), Water Amount: \(selectedWaterAmount ?? "N/A")"
                        let newReminder = Reminder(text: reminderText, isChecked: false)
                        reminders.append(newReminder)

                        // Reset to default
                        selectedRoom = "Bedroom"
                        selectedLight = "Full Sun"
                        selectedWateringDays = "Every day"
                        selectedWaterAmount = "20-50 ml"
                        plantName = ""

                        remindersheet.toggle()
                    }.foregroundColor(Color.trq))
                    .navigationBarBackButtonHidden(true)
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
