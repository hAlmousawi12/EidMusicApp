//
//  Music.swift
//  MusicApp
//
//  Created by Hussain on 10/5/21.
//

import SwiftUI

struct Music {
    var Name: String
    var pathName: String
    var singer: String
    var url: URL
}

var musics: [Music] = [
    
    .init(Name: "تيرارام تيرارام",pathName: "tiraram", singer: "زين", url: URL(string: "https://www.youtube.com/watch?v=h5WYUm1ktpY")!),
    .init(Name: "يا عيد",pathName: "yaEid", singer: "زين", url: URL(string: "https://www.youtube.com/watch?v=WxLjHsimItk")!),
    .init(Name: "العيد هل هلاله",pathName: "aleidHalHelalah", singer: "محمود الكويتي", url: URL(string: "https://www.youtube.com/watch?v=DbTuGa80nlI")!),
    .init(Name: "سنغني",pathName: "weWillSing", singer: "زين", url: URL(string: "https://www.youtube.com/watch?v=3KNIgCNBwYk")!),
    .init(Name: "الله الله اتانا العيد",pathName: "allahAllah", singer: "زين", url: URL(string: "https://www.youtube.com/watch?v=qJfcQy2EcJE")!),
    
]
