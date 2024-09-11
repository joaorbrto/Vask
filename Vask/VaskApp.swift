//
//  VaskApp.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 06/09/24.
//

import SwiftUI
import SwiftData

@main
struct MeuApp: App {
    var body: some Scene {
        WindowGroup {
            TarefaView()
                .modelContainer(for: Tarefa.self)
        }
    }
}

