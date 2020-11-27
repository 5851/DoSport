//
//  PlacesViewController.swift
//  DoSport
//
//  Created by MAC on 25.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

enum SectionPlaces: Int, CaseIterable {
    case specialPromotions
    case sportsType
}

final class PlacesViewController: UIViewController {

    // MARK: - Properties
    // Тестовые данные
    private var specialPromotions = [
        SectionCellModel(titleCell: "World Class", imageCell: #imageLiteral(resourceName: "vitasport")),
        SectionCellModel(titleCell: "GFitness", imageCell: #imageLiteral(resourceName: "world")),
        SectionCellModel(titleCell: "Vitasport", imageCell: #imageLiteral(resourceName: "fitness"))
    ]
    private var sportsType = [
        SectionCellModel(titleCell: "Спортивные\nплощадки", imageCell: #imageLiteral(resourceName: "1")),
        SectionCellModel(titleCell: "Тренировки", imageCell: #imageLiteral(resourceName: "ill_2")),
        SectionCellModel(titleCell: "Аренда залов", imageCell: #imageLiteral(resourceName: "1"))
    ]

    // MARK: - Outlet
    private let navigationbar = NavigationBar(frame: .zero)
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionPlaces, SectionCellModel>?

    // MARK: - View lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        setupUI()
        createDataSource()
        reloadData()
    }
}

// MARK: - Data Source
extension PlacesViewController {
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionPlaces, SectionCellModel>()
        snapshot.appendSections([.specialPromotions, .sportsType])
        snapshot.appendItems(specialPromotions, toSection: .specialPromotions)
        snapshot.appendItems(sportsType, toSection: .sportsType)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionPlaces, SectionCellModel>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cell) -> UICollectionViewCell? in
            guard let section = SectionPlaces(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .specialPromotions:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PromotionSectionCell.resuseId,
                    for: indexPath) as? PromotionSectionCell
                let model = self.specialPromotions[indexPath.row]
                cell?.configure(model: model)
                return cell
            case .sportsType:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TypeSportsCell.resuseId,
                    for: indexPath) as? TypeSportsCell
                let model = self.sportsType[indexPath.row]
                cell?.configure(model: model)
                return cell
            }
        })

        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let section = SectionPlaces(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .specialPromotions:
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: PromotionSectionHeader.resuseId,
                    for: indexPath) as? PromotionSectionHeader
                return sectionHeader
            case .sportsType:
                return nil
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PlacesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = SectionPlaces(rawValue: indexPath.section) else { return }
        switch section {
        case .specialPromotions:
            print("specialPromotions", indexPath.row)
        case .sportsType:
            print("sportsType", indexPath.row)
        }
    }
}

// MARK: - SetupUI
extension PlacesViewController {
    private func setupUI() {

        setupCollectionView()

        let stackView = UIStackView(arrangedSubviews: [
            navigationbar, collectionView
        ])
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view).offset(-80)
        }
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .white
        collectionView.register(PromotionSectionCell.self, forCellWithReuseIdentifier: PromotionSectionCell.resuseId)
        collectionView.register(TypeSportsCell.self, forCellWithReuseIdentifier: TypeSportsCell.resuseId)
        collectionView.register(PromotionSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PromotionSectionHeader.resuseId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
    }
}

// MARK: - Setup Layout
extension PlacesViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let section = SectionPlaces(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .specialPromotions:
                return self.createPromotionsSectionLayout()
            case .sportsType:
                return self.createSportTypesSectionLayout()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createPromotionsSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)

        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func createSportTypesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 20, trailing: 20)
        return section
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}
