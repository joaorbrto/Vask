//
//  CategoriaView.swift
//  Vask
//
//  Created by Joao Roberto Fernandes Magalhaes on 19/09/24.
//
import SwiftUI

struct CategoriaView: View {
    @StateObject private var viewModel = CategoriaViewModel()
    @State private var isAddingCategory = false
    @State private var newCategoryName = ""
    @State private var newCategoryDescription = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("tarefas por frequência")) {
                    ForEach(viewModel.categoriasPreProntas) { categoria in
                        NavigationLink(destination: TarefasPorCategoriaView(categoria: categoria)) {
                            Label {
                                VStack(alignment: .leading) {
                                    Text(categoria.nome)
                                        .font(.headline)
                                    Text(categoria.descricao)
                                        .font(.subheadline)
                                }
                            } icon: {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(colorForCategoria(categoria.nome))
                            }
                        }
                    }
                }
                
                Section {
                    ForEach(viewModel.categoriasCriadas) { categoria in
                        NavigationLink(destination: TarefasPorCategoriaView(categoria: categoria)) {
                            HStack {
                                Image(systemName: "list.bullet.circle.fill")
                                    .foregroundColor(.white)
                                VStack(alignment: .leading) {
                                    Text(categoria.nome)
                                        .font(.headline)
                                    Text(categoria.descricao)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteCategoria)
                }
            }
            .navigationTitle("Categorias")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingCategory.toggle()
                    }) {
                        Label("Adicionar Categoria", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingCategory) {
                addCategorySheet
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 86400, repeats: true) { _ in
                viewModel.renovarStatusTarefas()
            }
        }
    }
    
    private var addCategorySheet: some View {
        NavigationView {
            Form {
                TextField("Nome da Categoria", text: $newCategoryName)
                TextField("Descrição da Categoria", text: $newCategoryDescription)
                Button("Salvar Categoria", action: saveCategory)
            }
            .navigationTitle("Nova Categoria")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        isAddingCategory = false
                    }
                }
            }
        }
    }
    
    private func saveCategory() {
        viewModel.adicionarCategoria(nome: newCategoryName, descricao: newCategoryDescription)
        newCategoryName = ""
        newCategoryDescription = ""
        isAddingCategory = false
    }
}

private func colorForCategoria(_ nome: String) -> Color {
    switch nome {
    case "Tarefas Frequentes":
        return .red
    case "Tarefas Periódicas":
        return .orange
    case "Tarefas Pontuais":
        return .blue
    default:
        return .blue
    }
}

struct CategoriaView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriaView()
    }
}
