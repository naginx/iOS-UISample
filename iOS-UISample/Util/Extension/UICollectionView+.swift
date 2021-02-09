//
//  UICollectionView+.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/08.
//

import UIKit

extension UICollectionView {

    /// 指定のカラム数のレイアウトを作成する
    /// - Parameters:
    ///   - column: カラム数
    ///   - interMargin: セル間の余白。初期値0。
    ///   - outerMargin: セル全体に付与する上下左右の余白。初期値0。
    ///   - aspectRatio: 横を1としたときの縦の比率。初期値1。
    func makeColumnLayout(column: Int, interMargin: CGFloat = 0,
                          outerMargin: CGFloat = 0, aspectRatio: CGFloat = 1) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = interMargin
        layout.minimumLineSpacing = interMargin
        layout.sectionInset = UIEdgeInsets(top: outerMargin, left: outerMargin,
                                           bottom: outerMargin, right: outerMargin)
        let intervalCount = CGFloat(column) - 1
        let totalInterMargin = interMargin * intervalCount
        let totalOuterMargin = outerMargin * 2
        let baseCellSize = (bounds.width - totalInterMargin - totalOuterMargin) / CGFloat(column)
        layout.itemSize = CGSize(width: baseCellSize,
                                 height: baseCellSize * aspectRatio)
        collectionViewLayout = layout
    }
}
