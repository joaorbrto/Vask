//
//  TarefaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 06/09/24.
//

import SwiftUI

struct TarefaView: View {
    var body: some View {
        NavigationStack{
           Spacer()
                    NavigationLink("Tarefa1", destination: ContentView())
                    NavigationLink("Tarefa2", destination: ContentView())
                    NavigationLink("Tarefa3", destination: ContentView())
               .listRowBackground(Color.red)
                .navigationTitle("Tarefas")
        }
    }
}

#Preview {
    TarefaView()
}
