//
//  URLRequest+Extension.swift
//  Concert list
//
//  Created by georgiana.stefan
//

import Foundation
import Combine

class ImageLoader {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func publisher(for url: URL) -> AnyPublisher<UIImage, Error> {
        urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse, userInfo: [
                        NSURLErrorFailingURLErrorKey: url
                    ])
                }

                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
