//
//  ViewController.swift
//  Swiftly-Exercise
//
//  Created by Megan Herold on 2/27/20.
//  Copyright © 2020 Megan Herold. All rights reserved.
//

import UIKit

class ManagerSpecialsCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var layout: ManagerSpecialLayout?
    
    var oneUnit: Int {
        guard let layout = layout else { return 0 }
        return Int(UIScreen.main.bounds.width) / layout.canvasUnit
    }
    
    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ManagerSpecialItemView.self, forCellWithReuseIdentifier: ManagerSpecialItemView.reuseIdentifier)
        collectionView.register(ManagerSpecialsHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ManagerSpecialsHeaderView.reuseIdentifier)
        
        collectionView.backgroundColor = .systemBackground
        
        requestLayout()
    }
    
    // MARK: - Networking
    
    private func requestLayout() {
        guard let url = ManagerSpecialLayout.Endpoint.url else {
            presentOkAlert(message: "Invalid URL ⁉️")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.presentOkAlert(for: error)
                return
            }
            
            if let data = data {
                if let decodedLayout = try? JSONDecoder().decode(ManagerSpecialLayout.self, from: data) {
                    self?.layout = decodedLayout
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                    
                } else {
                    self?.presentOkAlert(message: "Failed to decode the layout ☹️")
                }
            } 
        }.resume()
        
    }
}

// MARK: - UICollectionDataSource

extension ManagerSpecialsCollectionViewController {
    
    override func numberOfSections(in: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return layout?.managerSpecials.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: ManagerSpecialsHeaderView.reuseIdentifier,
                                                                       for: indexPath)
            return view
        default:
            return UICollectionReusableView()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ManagerSpecialItemView.reuseIdentifier,
                                                          for: indexPath) as? ManagerSpecialItemView,
            let managerSpecial = managerSpecial(for: indexPath) else {
                return UICollectionViewCell()
        }
        
        cell.configure(for: managerSpecial)
        return cell
    }
    
    func managerSpecial(for indexPath: IndexPath) -> ManagerSpecialItem? {
        return layout?.managerSpecials[indexPath.row]
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ManagerSpecialsCollectionViewController : UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let item = layout?.managerSpecials[indexPath.row] else { return CGSize.zero }

        let width = item.width * oneUnit - Int(ManagerSpecialsCollectionViewLayout.padding)
        let height = item.height * oneUnit - Int(ManagerSpecialsCollectionViewLayout.padding)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Int(UIScreen.main.bounds.width), height: oneUnit * 3)
    }
    
}
