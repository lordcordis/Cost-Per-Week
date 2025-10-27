//
//  ViewAssembly.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 18.10.25.
//

import SwiftUI

final class ViewAssembly {
    
    static let persistency = PersistenceManager()
    static let navigationManager = NavigationManager()
    
    // home
    
    static func buildMainViewModel() -> HomeViewModel {
        return HomeViewModel(persistency: persistency)
    }
    
    static func buildHomeView() -> HomeView {
        return HomeView(viewModel: buildMainViewModel(), navigation: navigationManager)
    }
    
    // item cell
    
    static func buildItemViewModel(item: Item) -> ItemCellViewModel {
        return ItemCellViewModel(item: item, delegate: nil, weekOrDay: true)
    }
    
    static func buildItemCellView(item: Item) -> ItemCellView {
        return ItemCellView(viewModel: buildItemViewModel(item: item))
    }
    
    // item editor with new item
    
    static func buildNewItemDetailViewController() -> DetailViewModel {
        return DetailViewModel()
    }
    
    static func buildNewItemDetailView() -> DetailView {
        return DetailView(viewModel: buildNewItemDetailViewController())
    }
    
    // item editor with known item
    
    static func buildExistingItemDetailViewController(item: Item) -> DetailViewModel {
        return DetailViewModel(item: item)
    }
    
    static func buildExistingItemDetailView(item: Item) -> DetailView {
        return DetailView(viewModel: buildExistingItemDetailViewController(item: item))
    }
    
//    settings
    
    static func buildSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(weekOrDay: true, delegate: nil)
    }
    
    static func buildSettingsView(onClose: @escaping () -> Void) -> SettingsView {
        return SettingsView(viewModel: buildSettingsViewModel(), onClose: onClose)
    }
    
}

final class NavigationManager: ObservableObject {
    
    @Published var path = NavigationPath()
    
}

enum Destination: Hashable {
    case newItem
    case item(Item)
}
