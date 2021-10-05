//
//  HomeView.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        if vm.hero == nil || vm.team == nil {
            ProgressView()
        } else {
            TabView {
                HeroView()
                    .environmentObject(vm)
                    .tabItem {
                        Text("Hero")
                    }

                TeamView().environmentObject(vm)
                    .tabItem {
                        Text("Team")
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
