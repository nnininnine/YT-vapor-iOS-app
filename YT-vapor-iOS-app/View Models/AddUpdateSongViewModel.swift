//
//  AddUpdateSongViewModel.swift
//  YT-vapor-iOS-app
//
//  Created by Nuttapon Buaban on 15/11/2564 BE.
//

import Foundation

final class AddUpdateSongViewModel: ObservableObject {
    @Published var songTitle = ""
    
    var songId: UUID?
    
    var isUpdating: Bool {
        songId != nil
    }
    
    var buttonTitle: String {
        songId != nil ? "Update Song" : "Add Song"
    }
    
    init() {}
    
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songId = currentSong.id
    }
    
    func addSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: song,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let song = Song(id: songId, title: songTitle)
        
        try await HttpClient.shared.sendData(to: url, object: song, httpMethod: HttpMethods.PUT.rawValue)
        
    }
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task{
            do {
                if isUpdating {
                    try await updateSong()
                } else {
                    try await addSong()
                }
            } catch {
                print("❌ Error:\(error)")
            }
            completion()
        }
    }
}
