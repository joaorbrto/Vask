//
//  AddTarefaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 10/09/24.
//

import SwiftUI
import SwiftData

struct AddTarefaView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @State private var titulo = ""
    @State private var descricao = ""
    @State private var dataDeVencimento = Date()
    @State private var prioridade = "Média"
    @State private var status = "Pendente"
    
    let prioridades = ["Alta", "Média", "Baixa"]
    let statusList = ["Pendente", "Em Progresso", "Concluída"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações da Tarefa")) {
                    TextField("Título", text: $titulo)
                    TextField("Descrição", text: $descricao)
                    DatePicker("Data de Vencimento", selection: $dataDeVencimento, displayedComponents: .date)
                    Picker("Prioridade", selection: $prioridade) {
                        ForEach(prioridades, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Status", selection: $status) {
                        ForEach(statusList, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    Button(action: saveTarefa) {
                        Text("Salvar Tarefa")
                    }
                }
            }
            .navigationTitle("Nova Tarefa")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func saveTarefa() {
        let novaTarefa = Tarefa(titulo: titulo, descricao: descricao, dataDeVencimento: dataDeVencimento, prioridade: prioridade, status: status)
        modelContext.insert(novaTarefa)
        
        do {
            try modelContext.save()
            isPresented = false
        } catch {
            print("Erro ao salvar tarefa: \(error.localizedDescription)")
        }
    }
}
