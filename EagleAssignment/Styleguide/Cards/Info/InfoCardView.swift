//
//  InfoCard.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

protocol InfoCardDisplayable {
  var infoCardTitle: String {get}
  var infoCardSubtitle: String {get}
}

struct BaseInfoCardDisplayable: InfoCardDisplayable {
  var infoCardTitle: String
  var infoCardSubtitle: String
}

final class InfoCardView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelSubtitle: UILabel!
  
  // MARK: - Public Methods
  func fill(with model: InfoCardDisplayable) {
    labelTitle.text = model.infoCardTitle
    labelSubtitle.text = model.infoCardSubtitle
  }
}
