//
//  HomeView.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 18.10.25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @ObservedObject var navigation: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            List(viewModel.items) { item in
                ViewAssembly.buildItemCellView(item: item)
                    .onTapGesture {
                        navigation.path.append(Destination.item(item))
                    }
                    .listRowSeparator(.hidden)
                    .swipeActions {
                        Button {
                            withAnimation {
                                viewModel.deleteItem(item: item)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
            }
            .listStyle(.plain)
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.viewTitle())
            .onAppear {
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.settingsSheetPresented = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "tray")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        navigation.path.append(Destination.newItem)
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.pink)
                    }
                }
            }
            .sheet(isPresented: $viewModel.settingsSheetPresented, content: {
                ViewAssembly.buildSettingsView(sheetIsPresented: $viewModel.settingsSheetPresented)
                    .presentationDetents([.large])
            })
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .newItem:
                    ViewAssembly.buildNewItemDetailView()
                case .item(let item):
                    ViewAssembly.buildExistingItemDetailView(item: item)
                }
            }
        }
    }
}

#Preview {
    ViewAssembly.buildHomeView()
}
