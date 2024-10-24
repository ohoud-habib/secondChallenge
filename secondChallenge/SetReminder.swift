import SwiftUI

struct SetReminder: View {
    @State private var reminders: [Reminder] = []
    @State private var remindersheet = false

    var body: some View {
        NavigationView {
            VStack {
                if reminders.isEmpty {
                    Finished(remindersheet: $remindersheet)
                } else {
                    ReminderList(reminders: $reminders, remindersheet: $remindersheet)
                }
            }
            .sheet(isPresented: $remindersheet) {
                ReminderForm(reminders: $reminders, isPresented: $remindersheet)
            }
            
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ReminderList: View {
    @Binding var reminders: [Reminder]
    @Binding var remindersheet: Bool

    var body: some View {
        VStack {
            Text("Today")
                .font(.title)
                .foregroundColor(.white)
                .offset(x: -140, y: 10.55)

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
            .listStyle(PlainListStyle()) // Optional: Use PlainListStyle for a cleaner look
            
            addButton
                .padding(.bottom) // Added padding for better spacing
        }
        .navigationTitle("My Plants 🌱")
    }

    private var addButton: some View {
        Button(action: {
            remindersheet.toggle()
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.trq)
                Text("New Reminder")
                    .foregroundColor(.trq)
            }
        }
        .padding()
    }

    private func deleteItems(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
}

#Preview {
    SetReminder()
}
