//
//  Metadata.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import Foundation


struct Json : Codable {
    let metadata : [Metadata]
}

struct Metadata : Codable {
    let category : String
    let title : String
    let body : String
    let shareUrl : String
    let coverPhotoUrl : URL
    let date : Int
    let gallery : [Gallery]?
    let video : [Video]?
}

struct Gallery : Codable {
    let title: String
    let thumbnailUrl : URL
    let contentUrl : URL
}

struct Video : Codable {
    let title : String
    let thumbnailUrl : URL
    let youtubeId : String
}
