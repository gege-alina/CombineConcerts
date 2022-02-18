//
//  ConcertCellViewModel.swift
//  Concert list
//
//  Created by georgiana.stefan
//

import Foundation

struct ConcertCellViewModel {
    var bandName: String
    var placeOfConcert: String?
    var dateOfConcert: Date?
    var isConcertPaid: Bool
    
    init(band: String, place: String? = "Expirat", date: Date = Date() + 7, isConcertPaid: Bool = false) {
        self.bandName = band
        self.placeOfConcert = place
        self.dateOfConcert = date
        self.isConcertPaid = isConcertPaid
    }
}
