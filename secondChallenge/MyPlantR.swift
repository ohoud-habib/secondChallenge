import SwiftUI

struct MyPlantR: View {
    @State private var showActionSheet = false
    @State private var selectedAction: String? {
        didSet {
            saveSelection(key: "selectedAction", value: selectedAction)
        }
    }
    @State private var selectedRoom: String? {
        didSet {
            saveSelection(key: "selectedRoom", value: selectedRoom)
        }
    }
    @State private var selectedWateringDays: String? {
        didSet {
            saveSelection(key: "selectedWateringDays", value: selectedWateringDays)
        }
    }
    @State private var selectedWaterAmount: String? {
        didSet {
            saveSelection(key: "selectedWaterAmount", value: selectedWaterAmount)
        }
    }
    @State private var selectedLight: String? {
        didSet {
            saveSelection(key: "selectedLight", value: selectedLight)
        }
    }

    init() {
        // Load selections from UserDefaults
        self.selectedAction = loadSelection(key: "selectedAction")
        self.selectedRoom = loadSelection(key: "selectedRoom")
        self.selectedWateringDays = loadSelection(key: "selectedWateringDays")
        self.selectedWaterAmount = loadSelection(key: "selectedWaterAmount")
        self.selectedLight = loadSelection(key: "selectedLight")
    }

    var body: some View {
        VStack {
            
            Button("New Reminder") {
                showActionSheet.toggle()
            }
            .padding()
            .sheet(isPresented: $showActionSheet) {
                ActionSheetView(
                    selectedAction: $selectedAction,
                    selectedRoom: $selectedRoom,
                    selectedWateringDays: $selectedWateringDays,
                    selectedWaterAmount: $selectedWaterAmount,
                    selectedLight: $selectedLight
                )
            }

            if let selectedAction = selectedAction {
                HStack {
                    Text("You selected:")
                    Text(selectedAction)
                        .foregroundColor(.gray)
                }
                .padding()
                .font(.headline)
            }
            if let selectedRoom = selectedRoom {
                HStack {
                    Text("Room selected:")
                    Text(selectedRoom)
                        .foregroundColor(.gray)
                }
                .padding()
                .font(.headline)
            }
            if let selectedWateringDays = selectedWateringDays {
                HStack {
                    Text("Watering Days:")
                    Text(selectedWateringDays)
                        .foregroundColor(.gray)
                }
                .padding()
                .font(.headline)
            }
            if let selectedWaterAmount = selectedWaterAmount {
                HStack {
                    Text("Water Amount:")
                    Text(selectedWaterAmount)
                        .foregroundColor(.gray)
                }
                .padding()
                .font(.headline)
            }
            if let selectedLight = selectedLight {
                HStack {
                    Text("Light Requirement:")
                    Text(selectedLight)
                        .foregroundColor(.gray)
                }
                .padding()
                .font(.headline)
            }
        }
        .padding()
    }

    // Function to save selection to UserDefaults
    private func saveSelection(key: String, value: String?) {
        UserDefaults.standard.set(value, forKey: key)
    }

    // Function to load selection from UserDefaults
    private func loadSelection(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}

struct ActionSheetView: View {
    @Binding var selectedAction: String?
    @Binding var selectedRoom: String?
    @Binding var selectedWateringDays: String?
    @Binding var selectedWaterAmount: String?
    @Binding var selectedLight: String?

    @Environment(\.presentationMode) var presentationMode // Access to dismiss the sheet

    var body: some View {
        NavigationView {
            
            List {
                Section(header: Text("")) {
                    HStack {
                        Text("Room")
                        Spacer()
                        Text(selectedRoom ?? "Not selected")
                            .foregroundColor(.gray)
                    }
                    Menu(" Room") {
                        Button("Bedroom") {
                            selectedRoom = "Bedroom "
                        }
                        Button("Kitchen") {
                            selectedRoom = "Kitchen "
                        }
                    }
                    
                    
                    
                    HStack {
                        Text("Light")
                        Spacer()
                        Text(selectedLight ?? "Not selected")
                            .foregroundColor(.gray)
                    }
                    Menu(" Light") {
                        Button("Full Sun") {
                            selectedLight = "Full Sun"
                        }
                        Button("Partial Sun") {
                            selectedLight = "Partial Sun"
                        }
                        Button("Low Light") {
                            selectedLight = "Low Light"
                        }
                    }
                    
                }
                
                    HStack {
                        Text("Watering Days")
                        Spacer()
                        Text(selectedWateringDays ?? "Not selected")
                            .foregroundColor(.gray)
                    }
                    Menu(" Watering Days") {
                        Button("Every day") {
                            selectedWateringDays = "Every day"
                        }
                        Button("Every 2 days") {
                            selectedWateringDays = "Every 2 days"
                        }
                        Button("Every 3 days") {
                            selectedWateringDays = "Every 3 days"
                        }
                        Button("Once a week") {
                            selectedWateringDays = "Once a week"
                        }
                        Button("Every 10 days") {
                            selectedWateringDays = "Every 10 days"
                        }
                        Button("Every 2 weeks") {
                            selectedWateringDays = "Every 2 weeks"
                        }
                    }
                
               
                    HStack {
                        Text("Water Amount")
                        Spacer()
                        Text(selectedWaterAmount ?? "Not selected")
                            .foregroundColor(.gray)
                    }
                    Menu(" Water ") {
                        Button("20-50 ml") {
                            selectedWaterAmount = "20-50 ml"
                        }
                        Button("50-100 ml") {
                            selectedWaterAmount = "50-100 ml"
                        }
                        Button("100-200 ml") {
                            selectedWaterAmount = "100-200 ml"
                        }
                        Button("200-300 ml") {
                            selectedWaterAmount = "200-300 ml"
                        }
                    }
                
            }
            .navigationTitle("Set Reminder")
            .navigationBarItems(trailing: Button("Save") {
                // Dismiss the sheet
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    MyPlantR()
}
