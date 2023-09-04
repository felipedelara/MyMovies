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
                                   backdropPath: "/example_backdrop.jpg",
                                   genreIDS: [28, 12, 14],
                                   id: 12345,
                                   originalLanguage: "en",
                                   originalTitle: "Example Movie",
                                   overview: "This is an example",
                                   popularity: 123.45,
                                   posterPath: "/example_poster.jpg",
                                   releaseDate: "2023-09-01",
                                   title: "Example Movie Title",
                                   video: false,
                                   voteAverage: 7.8,
                                   voteCount: 1234))
    }
}
