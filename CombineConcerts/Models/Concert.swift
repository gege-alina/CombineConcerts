//
//  Concert.swift
//  Concert list
//
//  Created by georgiana.stefan
//

import Foundation
import UIKit

struct Concert {
    var bandName: String
    var placeOfConcert: String?
    var dateOfConcert: Date?
    var poster: UIImage?
    var isPaid: Bool = false
    
    init(band: String, place: String? = "Expirat", date: Date = Date() + 7, poster: UIImage? = nil) {
        self.bandName = band
        self.placeOfConcert = place
        self.dateOfConcert = date
        self.poster = poster
    }
    
    func getConcertCellVM() -> ConcertCellViewModel {
        return ConcertCellViewModel(band: self.bandName, place: self.placeOfConcert, date: self.dateOfConcert ?? Date() + 7, isConcertPaid: isPaid)
    }
}
