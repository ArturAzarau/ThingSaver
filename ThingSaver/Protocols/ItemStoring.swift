//
// Created by Артур Азаров on 21.01.2018.
// Copyright (c) 2018 Paul Hudson. All rights reserved.
//

import Foundation

protocol ItemStoring: class {
    associatedtype itemType
    var items: [itemType] { get set }
    var selectedItem: itemType? { get set }
    var savedKeyName: String { get set }

    func loadData()
    func saveData()
}

extension ItemStoring {
    func loadData() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()

        if let savedData = defaults.object(forKey: savedKeyName) as? Data {
            if let savedItems = try? decoder.decode([itemType].self, from: savedData) {
                items = savedItems
            }
        }
    }

    func saveData() {
        let defaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: items)
        defaults.set(data, forKey: savedKeyName)
    }
}