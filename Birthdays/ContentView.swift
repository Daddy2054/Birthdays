//
//  ContentView.swift
//  Birthdays
//
//  Created by Jean on 18/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @State private var friends: [Friend]=[
//        Friend(name: "Elton Lin", birthday: .now),
//        Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)),
//            ]
    @Query(sort: \Friend.birthday) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    @State private var newDate  =  Date.now
    
    var body: some View {
        NavigationStack {
//            List(friends,id: \.name) {
            List(friends) {
                friend in
                HStack {
                    if friend.isBirthdayToday {
                        Image(systemName: "birthday.cake")
                    }
                    Text(friend.name)
                        .bold(friend.isBirthdayToday)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom){
                VStack(alignment: .center, spacing: 20){                              Text("New Birthday").font(.headline)
                    DatePicker(selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save"){
                        let newFriend = Friend(name: newName, birthday: newDate)
//                        friends.append(newFriend)
                        context.insert(newFriend)
                        
                        newName = ""
                        newDate = Date.now
                    }.bold()
                }
                .padding()
                .background(.bar)
            }
//            .task {
//                context.insert(Friend(name: "Elton Lin", birthday: .now))
//                context.insert(Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0)))
//            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
