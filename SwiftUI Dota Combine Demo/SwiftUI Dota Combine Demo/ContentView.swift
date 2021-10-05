//
//  ContentView.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewMode = ViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
