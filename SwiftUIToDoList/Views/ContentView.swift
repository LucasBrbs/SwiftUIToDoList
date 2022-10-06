//
//  ContentView.swift
//  SwiftUIToDoList
//
//  Created by Lucas Barbosa de Oliveira on 20/04/22.
//

import SwiftUI

struct ContentView: View {
   
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showAddTodoView = false
    
    @FetchRequest(sortDescriptors: []) private var todosCD: FetchedResults<TodoCD>
    
    private func deleteTodo(offsets: IndexSet){
        for index in offsets{
            let todo = todosCD[index]
            viewContext.delete(todo)
        }
        
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("unresolved error \(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todosCD, id:\.self){ (todo) in
                    NavigationLink(destination:
                                    VStack {
                        Text(todo.name ?? "untitled")
                        Image(todo.category ?? "")
                            .resizable()
                            .frame(
                                width: 200,
                                height: 200
                            )
                    }
                    ){
                        
                        HStack {
                            Image(todo.category ?? "")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text(todo.name ?? "intitled")
                        }
                    }
                }
                .onDelete(perform: { IndexSet in //todos.remove(atOffsets: IndexSet)
                    deleteTodo(offsets: IndexSet)
                })
                .onMove(perform: { indices, newOffset in
                    //todos.move(fromOffsets: indices, toOffset: newOffset)
                })
            }
            .navigationBarTitle("To Do List")
            .navigationBarItems(
                leading:Button("Add") {
                //addTodo()
                self.showAddTodoView.toggle()
                }
                .sheet(isPresented: $showAddTodoView) {
                    NavigationView {
                        AddView(showAddTodoView: self.$showAddTodoView)
                            .navigationBarTitle("New Activity", displayMode: .inline)
                    }
                },
                trailing: EditButton()
            )
        }
    }
}

//struct AddTodoView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Binding var showAddTodoView: Bool
//    
//    @State private var name: String = ""
//    @State private var selectedCategory = 0
//    
//    var categoryTypes = ["Family","Personal","Work"]
//    
//    var body: some View {
////        VStack {
////            Text("Add todo")
////                .font(.largeTitle)
////            TextField("To do Name", text: $name)
////                .textFieldStyle(RoundedBorderTextFieldStyle())
////                .border(Color.black)
////                .padding()
////            
////            Text("Select category")
////            Picker("",selection: $selectedCategory) {
////                ForEach(0 ..< categoryTypes.count) {
////                    Text(self.categoryTypes[$0])
////                }
////            }
////            .pickerStyle(SegmentedPickerStyle())
////        }
////        .padding()
////            
////        Button("Done") {
////        self.showAddTodoView = false
////        let newTodoCD = TodoCD(context: viewContext)
////            newTodoCD.name = name
////            newTodoCD.category = categoryTypes[selectedCategory]
////            do {
////                try viewContext.save()
////            }
////            catch {
////                let error = error as NSError
////                fatalError("unressolved error:\(error)")
////            }
////        }
////    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



