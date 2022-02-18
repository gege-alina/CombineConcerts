//
//  AddConcertViewController.swift
//  Concert list
//
//  Created by georgiana.stefan 
//

import Foundation
import UIKit
//import RxSwift
import Combine

class AddConcertViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var bandTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addPosterButton: UIButton!
    
    private let concertSubject = PassthroughSubject<Concert, Error>()
//    private let concertSubject = PublishSubject<Concert>()
//    private let disposeBag = DisposeBag()
    
        var concertSubjectObservable: AnyPublisher<Concert, Error> {
            concertSubject.eraseToAnyPublisher()
        }
//    var concertSubjectObservable: Observable<Concert> {
//        concertSubject.asObservable()
//    }
    
    @IBAction func save() {
        let concert = Concert(band: bandTextField.text ?? " ", place: placeTextField.text)
        concertSubject.send(concert)
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadImage() {
        let urlString = "https://www.adobe.com/express/create/poster/media_1e036231ea97999b908dfca81b9c40cb3ae7b55f9.png?width=2000&format=webply&optimize=medium"
        let imageLoader = ImageLoader()
        let imageObs = imageLoader.publisher(for: URL(string: urlString)!)
        _ = imageObs
            .sink(receiveCompletion: { error in
                print(error)
            },
                  receiveValue: { image in
                DispatchQueue.main.async {
                    self.poster.image = image
                    print("image set")
                }
            })
            //.store(in: <#T##Set<Combine.AnyCancellable>#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}
