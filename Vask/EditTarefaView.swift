//
//  EditTarefaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 10/09/24.
//

import SwiftUI
import SwiftData

struct EditTarefaView: View {
    @Environment(\.modelContext) private var modelContext
    var tarefa: Tarefa
    
    @State private var titulo: String
    @State private var descricao: String
    @State private var dataDeVencimento: Date
    @State private var prioridade: String
    @State private var status: String
    
    init(tarefa: Tarefa) {
        self.tarefa = tarefa
        _titulo = State(initialValue: tarefa.titulo)
        _descricao = State(initialValue: tarefa.descricao)
        _dataDeVencimento = State(initialValue: tarefa.dataDeVencimento)
        _prioridade = State(initialValue: tarefa.prioridade)
        _status = State(initialValue: tarefa.status)
    }
    
    let prioridades = ["Alta", "Média", "Baixa"]
    let statusList = ["Pendente", "Em Progresso", "Concluída"]
    
    var body: some View {
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
                Button("Salvar Alterações", action: saveChanges)
            }
        }
        .navigationTitle("Editar Tarefa")
    }
    
    private func saveChanges() {
        tarefa.titulo = titulo
        tarefa.descricao = descricao
        tarefa.dataDeVencimento = dataDeVencimento
        tarefa.prioridade = prioridade
        tarefa.status = status
        
        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar alterações: \(error.localizedDescription)")
        }
    }
}
