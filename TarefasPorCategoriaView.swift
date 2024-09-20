//
//  TarefasPorCategoriaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 19/09/24.
//

import SwiftUI

struct TarefasPorCategoriaView: View {
    @ObservedObject var categoria: Categoria
    @State private var isAddingTask = false
    
    var body: some View {
        List {
            ForEach(categoria.tarefas, id: \.id) { tarefa in
                VStack(alignment: .leading) {
                    Text(tarefa.titulo).font(.headline)
                    Text("Prioridade: \(tarefa.prioridade)")
                    Text("Data de Vencimento: \(tarefa.dataDeVencimento, formatter: dateFormatter)")
                }
            }
            .onDelete(perform: deleteTarefa)
        }
        .navigationTitle(categoria.nome)
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
            AddTarefaToCategoryView(categoria: categoria, isPresented: $isAddingTask)
        }
    }
    
    private func deleteTarefa(at offsets: IndexSet) {
        for index in offsets {
            let tarefa = categoria.tarefas[index]
            categoria.removerTarefa(tarefa: tarefa)
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()


