//
//  CategoriaViewModel.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 19/09/24.
//
import SwiftUI

class CategoriaViewModel: ObservableObject {
    @Published var categoriasPreProntas: [Categoria] = []
    @Published var categoriasCriadas: [Categoria] = []

    init() {
        categoriasPreProntas.append(Categoria(nome: "Tarefas Frequentes", descricao: "Tarefas que precisam ser feitas diariamente."))
        categoriasPreProntas.append(Categoria(nome: "Tarefas Periódicas", descricao: "Tarefas que se repetem semanalmente."))
        categoriasPreProntas.append(Categoria(nome: "Tarefas Pontuais", descricao: "Tarefas com uma data única de conclusão."))
    }
    
    func adicionarCategoria(nome: String, descricao: String) {
        let novaCategoria = Categoria(nome: nome, descricao: descricao)
        categoriasCriadas.append(novaCategoria)
    }
    
    func deleteCategoria(at offsets: IndexSet) {
        categoriasCriadas.remove(atOffsets: offsets)
    }
    
    func renovarStatusTarefas() {
        for categoria in categoriasPreProntas {
            for tarefa in categoria.tarefas {
                if categoria.nome == "Tarefas Frequentes" {
                    tarefa.renovarStatus()
                } else if categoria.nome == "Tarefas Periódicas" {
                    tarefa.renovarStatusSemanal()
                }
            }
        }
        
        for categoria in categoriasCriadas {
            for tarefa in categoria.tarefas {
                if categoria.nome == "Tarefas Frequentes" {
                    tarefa.renovarStatus()
                } else if categoria.nome == "Tarefas Periódicas" {
                    tarefa.renovarStatusSemanal()
                }
            }
        }
    }
}
