//
//  ViewModel.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import Combine
import Foundation

class ViewModel: ObservableObject {
    @Published var hero: HeroModel?
    @Published var team: TeamModel?
    let service = NetworkService.shared
    var cancellable = Set<AnyCancellable>()

    init() {
        service.fetchData()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] heroData, teamData in
                self?.hero = heroData
                self?.team = teamData
            }.store(in: &cancellable)

//        service.fetchHero()
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                print("completion: ", completion)
//            } receiveValue: { [weak self] data in
//                print("hero data: ", data)
//                self?.hero = data
//            }.store(in: &cancellable)
    }
}
