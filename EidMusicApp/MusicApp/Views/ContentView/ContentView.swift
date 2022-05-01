//
//  ContentView.swift
//  MusicApp
//
//  Created by Hussain on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea(.all)
            VStack {
                header
                Spacer()
                info
                
                PNP
                Spacer()
                links
            }.padding()
        }.onAppear {
            vm.setupAVAudioSession()
        }
    }
}

extension ContentView {
    
    var header: some View {
        HStack {
            LottieView(name: "left", loopMode: .loop)
            Spacer()
            LottieView(name: "mid", loopMode: .loop)
            Spacer()
            LottieView(name: "right", loopMode: .loop)
        }
        .frame(height: 100)
    }
    
    var info: some View {
        VStack(alignment: .trailing) {
            Image(vm.currentMusic.Name)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            VStack(alignment: .trailing, spacing: 10) {
                Text(vm.currentMusic.Name)
                    .foregroundColor(.prime)
                    .font(.system(size: 40, weight: .semibold, design: .default))
                
                Text(vm.currentMusic.singer)
                    .foregroundColor(.sec)
                    .font(.system(size: 25, weight: .regular, design: .default))
            }
        }
    }
    
    var PNP: some View {
        HStack {
            Image(systemName: "backward.end.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.prime)
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    vm.prevMusic()
                }
            
            
            Image(systemName: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.prime)
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    vm.playMusic()
                }
            
            Image(systemName: "forward.end.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.prime)
                .frame(width: 50, height: 50)
                .padding()
                .onTapGesture {
                    vm.NextMusic()
                }
        }
    }
    
    var links: some View {
        Link(destination: vm.currentMusic.url) {
            ButtonShape(imageName: "youtube")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
