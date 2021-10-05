//
//  HeroView.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import Kingfisher
import SwiftUI

struct HeroView: View {
    @EnvironmentObject var vm: ViewModel
    @State var isTap = -1

    let url = "https://api.opendota.com"

    var body: some View {
        ZStack {
            Image("bg").resizable().aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)

            HStack {
                LottieView(name: "magic", loopMode: .loop)
                    .frame(width: 250, height: 250)
                Spacer()
            }.frame(maxWidth: .infinity)

            ScrollView(.vertical, showsIndicators: false, content: {
                ScrollViewReader(content: { proxy in
                    VStack(spacing: -60) {
                        ForEach(vm.hero!, id: \.self) { hero in
                            HeroCard(hero)
                                .id(hero.heroID)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            self.isTap = (self.isTap == hero.heroID ? -1 : hero.heroID)
                                            proxy.scrollTo(hero.heroID, anchor: .center)
                                        }
                                    }
                                }
                        }
                    }
                })

            }).frame(maxWidth: .infinity)
        }.statusBar(hidden: true)
    }
}

extension HeroView {
    func HeroCard(_ hero: HeroModelElement) -> some View {
        KFImage(URL(string: self.url + hero.img)!).resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: self.isTap == hero.heroID ? 384 : 256, height: self.isTap == hero.heroID ? 288 : 216)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .fixedSize(horizontal: false, vertical: true)
            .scaleEffect(0.9)
            .rotation3DEffect(
                .degrees(40),
                axis: (x: 1.0, y: -1.0, z: 0.0),
                anchor: .center,
                perspective: 1.0
            )
            .shadow(color: Color.black.opacity(0.8), radius: 2, x: 0, y: 1)
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView().environmentObject(ViewModel())
    }
}
