//
//  ReminderList.swift
//  secondChallenge
//
//  Created by ohoud on 25/04/1446 AH.
//

import SwiftUI

struct ReminderList: View {
    @Binding var reminders: [Reminder]
    @Binding var remindersheet: Bool
    var onEdit: (Reminder) -> Void

    var body: some View {
        VStack {
            
            Text("Today")
             .font(.title)
              .foregroundColor(.white)
                 .offset(x: -140, y: 10.55)
            List {
                ForEach(reminders.sorted(by: { !$0.isChecked && $1.isChecked })) { reminder in
                    HStack {
                        ReminderView(reminder: reminder, toggleAction: {
                            if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                reminders[index].isChecked.toggle()
                            }
                        }, editAction: {
                            onEdit(reminder) 
                        })
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
                Spacer()
            }
            
        }
        .padding()
    }

    private func deleteItems(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
}
#Preview {
    ReminderList(reminders: .constant([]), remindersheet: .constant(false), onEdit: { _ in })
}
