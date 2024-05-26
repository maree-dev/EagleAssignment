//
//  UsedDaysListView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class UsedDaysListView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var stackView: UIStackView!
  
  // MARK: - Public Methods
  func fill(with model: [InfoCardDisplayable]) {
    stackView.subviews.forEach {$0.removeFromSuperview()}
    
    let cards: [InfoCardView] = model.map { item in
      let card: InfoCardView = .instance()!
      card.fill(with: BaseInfoCardDisplayable(infoCardTitle: item.infoCardTitle, infoCardSubtitle: item.infoCardSubtitle))
      return card
    }

    cards.forEach {stackView.addArrangedSubview($0)}
  }
}
