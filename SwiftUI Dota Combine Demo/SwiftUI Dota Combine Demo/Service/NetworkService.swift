//
//  NetworkService.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import Combine
import Foundation

enum DotaError {
    case someError
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    var cancellable = Set<AnyCancellable>()

//    func fetchData(completion: @escaping (Result<(HeroModel, TeamModel), Never>) -> Void) {
//        let zipPublisher = Publishers.Zip(self.fetchHero(), self.fetchTeam())
//        zipPublisher.sink { item in
//            completion(.success(item))
//        }.store(in: &self.cancellable)
//    }

    func fetchData() -> AnyPublisher<(HeroModel, TeamModel), Error> {
        Future<(HeroModel, TeamModel), Error> { [weak self] promise in
            if let self = self {
                let zipPuiblisher = Publishers.Zip(self.fetchHero(), self.fetchTeam())
                zipPuiblisher.sink { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print("error: ", error.localizedDescription)
                    }
                } receiveValue: { items in
                    promise(.success(items))
                }.store(in: &self.cancellable)
            } else {
                promise(.failure(DotaError.someError as! Error))
            }
        }.eraseToAnyPublisher()
    }

    func fetchHero() -> AnyPublisher<HeroModel, Never> {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        guard let url = url else {
            return Just([]).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .filter { output in
                (output.response as! HTTPURLResponse).statusCode == 200
            }.map {
                $0.data
            }.decode(type: HeroModel.self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func fetchTeam() -> AnyPublisher<TeamModel, Never> {
        let url = URL(string: "https://api.opendota.com/api/teams")
        guard let url = url else {
            return Just([]).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .filter { output in
                (output.response as! HTTPURLResponse).statusCode == 200
            }.map {
                $0.data
            }.decode(type: TeamModel.self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
