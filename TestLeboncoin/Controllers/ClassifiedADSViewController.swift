//
//  ClassifiedADSViewController.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit
import Combine

class ClassifiedADSViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewLayout())
    
    typealias collectionViewDiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    
    private var dataSource: collectionViewDiffableDataSource?
    
    let classifiedADSViewModel = ClassifiedADSViewModel()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = "Leboncoin"
        
        configureLayout()
        configureCollectionViewDataSource()
        configureSnaphot()
        setupListeners()
    }
    
    private func configureLayout() {
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor,
                                      leading: view.safeAreaLayoutGuide.leadingAnchor,
                                      trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.register(ClassifiedADCell.self, forCellWithReuseIdentifier: ClassifiedADCell.identifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.collectionViewLayout = configureCollectionViewLayout()
    }
    
    func setupListeners() {
        classifiedADSViewModel.categories
            .sink { [weak self] categories in
                self?.configureSnaphot()
            }.store(in: &subscriptions)
        
        classifiedADSViewModel.currentClassifiedADS
            .sink { [weak self] currentClassifiedADS in
                self?.configureSnaphot()
            }.store(in: &subscriptions)
    }
}

// MARK: - Collection View
extension ClassifiedADSViewController {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {  // Categories
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth((1.0)),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                       heightDimension: .fractionalHeight(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
                section.interGroupSpacing = 10
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .topLeading)
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            } else {    // Classified ADS
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth((0.5)),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(0.7))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: UICollectionView.elementKindSectionHeader,
                                                                                alignment: .topLeading)
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            }
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func configureCollectionViewDataSource() {
        dataSource = collectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            if let category = itemIdentifier as? LBCCategory {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                    return nil
                }
                cell.configure(category: category)
                return cell
            } else if let classifiedAD = itemIdentifier as? ClassifiedAD {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifiedADCell.identifier, for: indexPath) as? ClassifiedADCell else {
                    return nil
                }
                
                cell.categoryName = self.classifiedADSViewModel.categoryName(id: classifiedAD.categoryId)
                cell.configure(classifiedAD: classifiedAD)
                
                if let urlString = classifiedAD.imagesUrl.thumb {
                    self.classifiedADSViewModel.fetchImage(urlString: urlString, cell: cell)
                }
                return cell
            }
            
            return nil
        })
        
        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                   withReuseIdentifier: SectionHeaderView.identifier,
                                                                                          for: indexPath) as? SectionHeaderView else { return nil }
            
            sectionHeaderView.configure(section: indexPath.section)
            
            return sectionHeaderView
        }
    }
    
    func configureSnaphot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        currentSnapshot.appendSections([.categories, .classifiedADS])
        currentSnapshot.appendItems(classifiedADSViewModel.categories.value, toSection: .categories)
        currentSnapshot.appendItems(classifiedADSViewModel.currentClassifiedADS.value, toSection: .classifiedADS)
        
        DispatchQueue.main.async { [weak self] in
            self?.dataSource?.apply(currentSnapshot)
        }
    }
}

// MARK: - Collection View Delegate

extension ClassifiedADSViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            print(classifiedADSViewModel.categories.value[indexPath.row].name)
            classifiedADSViewModel.category = indexPath.row + 1
        } else if indexPath.section == 1 {
            print(classifiedADSViewModel.currentClassifiedADS.value[indexPath.row].id)
            let classifiedAD = classifiedADSViewModel.currentClassifiedADS.value[indexPath.row]
            let detailViewModel = DetailViewModel(classifiedAD: classifiedAD)
            detailViewModel.categoryName = classifiedADSViewModel.categoryName(id: classifiedAD.categoryId)
            let detailViewController = DetailViewController()
            detailViewController.detailViewModel = detailViewModel
            navigationController?.pushViewController(detailViewController, animated: true)
            
        }
    }
}
