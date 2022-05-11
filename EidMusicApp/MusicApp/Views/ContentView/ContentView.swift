//
//  ContentView.swift
//  MusicApp
//
//  Created by Hussain on 10/5/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State var isMusicClicked = false
    @State var meow = false
    var body: some View {
        ZStack {
            Color.bg.edgesIgnoringSafeArea(.all)
            VStack {
                
                header
                Spacer()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(0..<Int(musics.count/2)) { i in
                            HStack {
                                Image(musics[i].Name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(15)
                                    .padding(5)
                                    .onTapGesture {
                                        withAnimation {
                                            vm.i = i
                                            vm.currentMusic = musics[i]
                                            isMusicClicked.toggle()
                                            if vm.isPlaying {
                                                vm.playMusic()
                                            }
                                            vm.playMusic()
                                            meow = true
                                        }
                                    }
                                Image(musics[i+2].Name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(15)
                                    .padding(5)
                                    .onTapGesture {
                                        withAnimation {
                                            vm.i = i+2
                                            vm.currentMusic = musics[i+2]
                                            isMusicClicked.toggle()
                                            if vm.isPlaying {
                                                vm.playMusic()
                                            }
                                            vm.playMusic()
                                            meow = true
                                        }
                                    }
                            }
                        }
                        
                        if (musics.count % 2) != 0 {
                            Image(musics.last!.Name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(15)
                                .padding(5)
                                .onTapGesture {
                                    withAnimation {
                                        vm.i = musics.count - 1
                                        vm.currentMusic = musics.last!
                                        isMusicClicked.toggle()
                                        if vm.isPlaying {
                                            vm.playMusic()
                                        }
                                        vm.playMusic()
                                        meow = true
                                    }
                                }
                        }
                    }
                }
                Spacer()
                if meow {
                Divider()
                HStack {
                    Image(vm.currentMusic.Name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 50)
                    VStack(alignment: .leading) {
                        Text(vm.currentMusic.Name)
                            .font(.title2)
                            .foregroundColor(.prime)
                        Text(vm.currentMusic.singer)
                            .font(.title3)
                            .foregroundColor(.sec)
                    }
                    Spacer()
                    
                    
                    HStack {
                        if vm.i != 0 {
                            Button(action: vm.prevMusic) {
                                Image(systemName: "backward.end.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(!vm.isRepeated && vm.i == 0 ? .sec : .prime)
                                    .frame(width: 20, height: 20)
                                    .padding()
                            }
                        }
                        Button(action: vm.playMusic) {
                            Image(systemName: vm.isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.prime)
                                .frame(width: 20, height: 20)
                                .padding()
                        }
                        if vm.i != (musics.count-1) {
                            Button(action: vm.NextMusic) {
                                Image(systemName: "forward.end.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(!vm.isRepeated && vm.i == (musics.count-1) ? .sec : .prime)
                                    .frame(width: 20, height: 20)
                                    .padding()
                            }
                        }
                    }
                    
                }
                .frame(height: 50)
                .padding(10)
                .onTapGesture {
                    isMusicClicked.toggle()
                }
                }
            }.padding()
            
        }
        .onAppear {
            vm.setupAVAudioSession()
        }
        .sheet(isPresented: $isMusicClicked) {
            VStack {
                Capsule()
                    .fill(Color.sec)
                    .frame(width: 40, height: 5)
                    .padding()
                Spacer()
                info
                PNP
                Spacer()
                links
            }
        }
    }
}

extension ContentView {
    
    var header: some View {
        HStack {
//            LottieView(name: "left", loopMode: .loop)
//            Spacer()
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
            
            Button {
                vm.isShuffle.toggle()
            } label: {
                Image(systemName: "shuffle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(vm.isShuffle ? .prime : .sec)
                    .frame(width: 30, height: 30)
                    .padding()
            }
            
            Button(action: vm.prevMusic) {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(!vm.isRepeated && vm.i == 0 ? .sec : .prime)
                    .frame(width: 30, height: 30)
                    .padding()
            }.disabled(!vm.isRepeated && vm.i == 0)
            
            Button(action: vm.playMusic) {
                Image(systemName: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.prime)
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            Button(action: vm.NextMusic) {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(!vm.isRepeated && vm.i == (musics.count-1) ? .sec : .prime)
                    .frame(width: 30, height: 30)
                    .padding()
                
            }.disabled(!vm.isRepeated && vm.i == (musics.count-1))
            
            Button {
                vm.isRepeated.toggle()
            } label: {
                Image(systemName: "repeat")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(vm.isRepeated ? .prime : .sec)
                    .frame(width: 30, height: 30)
                    .padding()
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
