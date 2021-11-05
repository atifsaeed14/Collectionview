//
//  DashboardViewController.swift
//  Atif Saeed
//
//  Created by Atif Saeed on 10/10/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Properties
    
    var isDragGestureEnded: Bool = true
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var dashboardCollectionView: UICollectionView! {
        didSet {
        }
    }
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "aaa"
        setupCollectionView()
    }
    
    
    // MARK: - Helping Methods
    
    func setupCollectionView() {
        
        dashboardCollectionView.registerNib(with: CollectionViewCell.self)
        
        dashboardCollectionView.delegate = self
        dashboardCollectionView.dataSource = self
        
        let customLayout = CustomLayout()
        customLayout.delegate = self
        dashboardCollectionView.collectionViewLayout = customLayout
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(moveCell))
        dashboardCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    // MARK: - Action Methods
    
    @objc func moveCell(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = dashboardCollectionView.indexPathForItem(at: gesture.location(in: dashboardCollectionView)) else {
                return
            }
            isDragGestureEnded = false
            dashboardCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            dashboardCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: dashboardCollectionView))
        case .ended:
            isDragGestureEnded = true
            self.dashboardCollectionView.performBatchUpdates({
                self.dashboardCollectionView.endInteractiveMovement()
            }, completion: nil)
        default:
            isDragGestureEnded = true
            dashboardCollectionView.cancelInteractiveMovement()
        }
    }
    
}


// MARK: - CustomLayoutDelegate

extension DashboardViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: CustomLayout, cellSizeForItemAtIndex indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize {
        let oneCellHeight: CGFloat = (layout.contentWidth / 1.4) / 4
        let oneCellWidth: CGFloat = layout.contentWidth / CGFloat(layout.numberOfColumns)
        let itemCellSize: CGSize = CGSize(width: oneCellWidth, height: oneCellHeight)
        return itemCellSize
    }
}


// MARK: - UICollectionView DataSource

extension DashboardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(with: CollectionViewCell.self, at: indexPath) else {
            fatalError("xib doesn't exists")
        }
        return cell
    }
}


// MARK: - UICollectionView Delegate

extension DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.row == 0 {
            return IndexPath(row: originalIndexPath.row, section: originalIndexPath.section)
        }
        return proposedIndexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard !isDragGestureEnded else {
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
}

