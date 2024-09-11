//
//  TarefaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 06/09/24.
//

import SwiftUI
import SwiftData

struct TarefaView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Tarefa.prioridade, order: .reverse) private var tarefas: [Tarefa] // Ordena por prioridade
    
    @State private var isAddingTask = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tarefas) { tarefa in
                    NavigationLink(destination: EditTarefaView(tarefa: tarefa)) {
                        VStack(alignment: .leading) {
                            Text(tarefa.titulo).font(.headline)
                            Text(tarefa.descricao).font(.subheadline)
                            Text("Vencimento: \(tarefa.dataDeVencimento, formatter: dateFormatter)")
                            Text("Prioridade: \(tarefa.prioridade)")
                            Text("Status: \(tarefa.status)")
                        }
                    }
                }
                .onDelete(perform: deleteTarefa)
            }
            .navigationTitle("Tarefas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingTask.toggle()
                    }) {
                        Label("Adicionar Tarefa", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingTask) {
                AddTarefaView(isPresented: $isAddingTask)
                    .environment(\.modelContext, modelContext)
            }
        }
    }

    private func deleteTarefa(at offsets: IndexSet) {
        for index in offsets {
            let tarefa = tarefas[index]
            modelContext.delete(tarefa)
        }
        try? modelContext.save()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()


#Preview {
    TarefaView()
}
