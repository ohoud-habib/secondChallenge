import SwiftUI

struct SetReminder: View {
    @State private var reminders: [Reminder] = []
    @State private var remindersheet = false
    @State private var editingReminder: Reminder?

    var body: some View {
        NavigationView {
            VStack {
                if reminders.isEmpty {
                    MainPage(remindersheet: $remindersheet)
                } else if allRemindersChecked() {
                    Finished(remindersheet: $remindersheet)
                } else {
                    ReminderList(reminders: $reminders, remindersheet: $remindersheet, onEdit: editReminder)
                }
            }
            .sheet(isPresented: $remindersheet) {
                ReminderForm(reminders: $reminders, isPresented: $remindersheet, editingReminder: $editingReminder)
                    .onDisappear {
                     editingReminder = nil
                                        }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func editReminder(reminder: Reminder) {
        editingReminder = reminder
        remindersheet = true // Show the reminder form
    }

    private func allRemindersChecked() -> Bool {
        reminders.allSatisfy { $0.isChecked }
    }
}


#Preview {
    SetReminder()
}
