//
//  MoviesViewController.swift
//  ThingSaver
//
//  Created by Paul Hudson on 22/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import QuickLook
import UIKit

class MoviesViewController: UICollectionViewController, QLPreviewControllerDataSource, ItemStoring, NavigationBarStyling {
    typealias itemType = Movie

    var items = [itemType]()
    var selectedItem: itemType?
    var savedKeyName = "SavedMovies"
    var fileExtension: String = "mp4"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addExampleData))

        navigationController?.navigationBar.isTranslucent = false
        setCustomTitle(of: "MOVIES")

        loadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        return cell
    }



    @objc func addExampleData() {
        do {
            try addItem()
            collectionView?.insertItems(at: [IndexPath(item: items.count - 1, section: 0)])
        } catch {
            print("Failed to create item: \(error.localizedDescription)")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(indexPath.item)
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let selectedFile = selectedItem else { fatalError("Attempted to preview without selecting anything") }
        return Helper.getPathInDocumentsDirectory(selectedFile.filename) as QLPreviewItem
    }
}
