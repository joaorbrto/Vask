//
//  Classes.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 06/09/24.
//

import Foundation

class Tarefa: Identifiable, ObservableObject {
    let id = UUID()
    @Published var titulo: String
    @Published var descricao: String
    @Published var dataDeVencimento: Date
    @Published var prioridade: String
    @Published var status: String
        
    init() {
        self.titulo = ""
        self.descricao = ""
        self.dataDeVencimento = Date.now + 3600
        self.prioridade = ""
        self.status = ""
    }
    
    init(titulo: String, descricao: String, dataDeVencimento: Date, prioridade: String, status: String) {
        self.titulo = titulo
        self.descricao = descricao
        self.dataDeVencimento = dataDeVencimento
        self.prioridade = prioridade
        self.status = status
    }
}

class Categoria: Identifiable, ObservableObject {
    let id = UUID()
    @Published var nome: String
    @Published var descricao: String
    @Published var tarefas: [Tarefa] = []
    init(nome: String, descricao: String) {
        self.nome = nome
        self.descricao = descricao
    }
    func adicionarTarefa(tarefa: Tarefa) {
        tarefas.append(tarefa)
        ordenarTarefasPorPrioridade()
    }
    func removerTarefa(tarefa: Tarefa) {
        tarefas.removeAll { $0.id == tarefa.id }
    }
    private func prioridadeValor(_ prioridade: String) -> Int {
        switch prioridade {
        case "Alta": return 3
        case "Média": return 2
        case "Baixa": return 1
        default: return 0
        }
    }
    func ordenarTarefasPorPrioridade() {
        tarefas.sort { prioridadeValor($0.prioridade) > prioridadeValor($1.prioridade) }
    }
}

