//
//  SongListViewModel.swift
//  YT-vapor-iOS-app
//
//  Created by Nuttapon Buaban on 14/11/2564 BE.
//

import SwiftUI

class SongListViewModel: ObservableObject  {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let songResponse: [Song] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func deleteSong(at offset: IndexSet) {
        offset.forEach{ i in
            guard let songId = self.songs[i].id else {
                return
            }
            guard let url = URL(string: Constants.baseURL + Endpoints.songs + "/\(songId)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: songId, url: url)
                } catch {
                    print("❌ Error:\(error)")
                }
            }
        }
        songs.remove(atOffsets: offset)
    }
}
