//
//  AddUpdateSong.swift
//  YT-vapor-iOS-app
//
//  Created by Nuttapon Buaban on 15/11/2564 BE.
//

import SwiftUI

struct AddUpdateSong: View {
    
    @ObservedObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button{
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSong(viewModel: AddUpdateSongViewModel())
    }
}
