//
//  MovieDetail.swift
//  MyMovies
//
//  Created by Felipe Lara on 03/09/2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie // Assuming you have a Movie struct defined

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.title)
                    .padding(.bottom, 8)

                Text("Release Date: \(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Overview:")
                    .font(.headline)
                    .padding(.top, 16)

                Text(movie.overview)
                    .font(.body)

                Text("Popularity: \(String(format: "%.2f", movie.popularity))")
                    .font(.headline)
                    .padding(.top, 16)

                Text("Average Vote: \(String(format: "%.2f", movie.voteAverage))")
                    .font(.headline)

                Text("Vote Count: \(movie.voteCount)")
                    .font(.headline)
                    .padding(.bottom, 16)

                if movie.video {
                    Button(action: {
                        // Handle video trailer action here
                    }) {
                        Text("Watch Trailer")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .navigationBarTitle(movie.title)
        }
    }
}
struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(adult: false,
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
