//
//  MovieListItem.swift
//  MyMovies
//
//  Created by Felipe Lara on 03/09/2023.
//

import SwiftUI

struct MovieListItem: View {
    
    let movie: Movie
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                // Poster Image
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { phase in

                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                            .foregroundColor(.gray)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                // Title and Release Date
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                    Text("Release Date: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.padding()

                Spacer()
            }
            .padding()
        }
    }
}

struct MovieListItem_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MovieListItem(movie: Movie(adult: false,
                                   backdropPath: "",
                                   genreIDS: [],
                                   id: 1,
                                   originalLanguage: "Original language",
                                   originalTitle: "Title here",
                                   overview: "Overview here",
                                   popularity: 10.0,
                                   posterPath: "",
                                   releaseDate: "12/01/2001",
                                   title: "Movie title",
                                   video: false, voteAverage: 10.0,
                                   voteCount: 100))
    }
}
