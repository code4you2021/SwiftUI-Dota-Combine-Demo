//
//  TeamView.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import SwiftUI

struct TeamView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        List(vm.team!, id: \.teamid) { team in
            Text(team.name)
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
