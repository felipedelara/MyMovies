//
//  ContentView.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import SwiftUI
import CoreData

struct MovieListView: View {

    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {

        NavigationView {

            switch viewModel.state {

            case .loading:
                ProgressView("Loading...")

            case .content(let movies):

                List(movies, id: \.id) { movie in
                    MovieListItem(movie: movie)

                }.listStyle(.plain)
                    .navigationTitle("Movies")

            case .error(let errorMessage):
                VStack {
                    Text("Error: \(errorMessage)")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()

                    Button("Try again") {
                        Task {
                            await viewModel.populateMovies()
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 40.0)
                    .buttonStyle(PrimaryButtonStyle())
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

