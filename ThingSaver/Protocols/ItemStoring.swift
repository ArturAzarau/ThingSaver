//
// Created by Артур Азаров on 21.01.2018.
// Copyright (c) 2018 Paul Hudson. All rights reserved.
//

import UIKit

protocol ItemStoring: class {
    associatedtype itemType: Item
    var items: [itemType] { get set }
    var selectedItem: itemType? { get set }
    var savedKeyName: String { get set }
    var fileExtension: String { get set }

    func loadData()
    func saveData()
}

extension ItemStoring where Self: UIViewController{
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
        let encoder = JSONEncoder()

        if let data = try? encoder.encode(items) {
            defaults.set(data, forKey: savedKeyName)
        } else {
            fatalError("Couldn't prepare items for saving.")
        }
    }

    func addItem() throws {
        guard let sourceURL = Bundle.main.url(forResource: "example", withExtension: fileExtension) else {
            fatalError("Unable to locate input file")
        }

        let filename = NSUUID().uuidString + ".\(fileExtension)"
        let destURL = Helper.getPathInDocumentsDirectory(filename)
        let fm = FileManager.default

        try fm.copyItem(at: sourceURL, to: destURL)
        let item = itemType(filename: filename)
        items.append(item)
        saveData()

    }
}