//
//  AddConcertViewController.swift
//  Concert list
//
//  Created by georgiana.stefan 
//

import Foundation
import UIKit
import RxSwift

class AddConcertViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var bandTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addPosterButton: UIButton!
    
    private let concertSubject = PublishSubject<Concert>()
    private let disposeBag = DisposeBag()
    
    var concertSubjectObservable: Observable<Concert> {
        concertSubject.asObservable()
    }
    
    @IBAction func save() {
        let concert = Concert(band: bandTextField.text ?? " ", place: placeTextField.text)
        concertSubject.onNext(concert)
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadImage() {
        let urlString = "https://www.adobe.com/express/create/poster/media_1e036231ea97999b908dfca81b9c40cb3ae7b55f9.png?width=2000&format=webply&optimize=medium"
        let imageObs = URL(string: urlString)!.downloadImage()
        imageObs
            .subscribe(onNext: { image in
                DispatchQueue.main.async {
                    self.poster.image = image
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}
