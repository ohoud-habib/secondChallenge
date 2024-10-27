import SwiftUI

struct SetReminder: View {
    @State private var reminders: [Reminder] = []
    @State private var remindersheet = false

    var body: some View {
        NavigationView {
            VStack {
                if reminders.isEmpty {
                    MainPage(remindersheet: $remindersheet)
                } else if allRemindersChecked() {
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

    private func allRemindersChecked() -> Bool {
        reminders.allSatisfy { $0.isChecked }
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
                
                ForEach(reminders.sorted(by: { !$0.isChecked && $1.isChecked })) { reminder in
                    ReminderView(reminder: reminder) {
                        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                            reminders[index].isChecked.toggle()
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            
            addButton
                .padding(.bottom)
        }
        .navigationTitle("My Plants 🌱")
        .navigationBarBackButtonHidden(true)
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
