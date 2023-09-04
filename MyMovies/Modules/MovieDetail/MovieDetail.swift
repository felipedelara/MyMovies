//
//  MovieDetail.swift
//  MyMovies
//
//  Created by Felipe Lara on 03/09/2023.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")) { phase in
                    switch phase {
                    case .empty, .failure(_):
                        Color.gray
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    @unknown default:
                        EmptyView()
                    }
                }

                RatingView(averageVote: movie.voteAverage)
                    .padding()

                Text("Release Date: \(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom)

                Text("Overview")
                    .font(.headline)
                    .padding(.horizontal)
                Text(movie.overview)
                    .font(.body)
                    .padding()

                Text("Popularity: \(String(format: "%.2f", movie.popularity))")
                    .font(.headline)
                    .padding()

                Text("Vote Count: \(movie.voteCount)")
                    .font(.headline)
                    .padding()

            }
            .navigationBarTitle(movie.title)
        }
    }
}

struct RatingView: View {
    let averageVote: Double

    var body: some View {

        HStack {
            Text("Average Vote:")
                .font(.headline)
            ForEach(0..<5) { index in
                Image(systemName: index < Int(averageVote / 2.0) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            Text(String(format: "%.1f", averageVote) + "/10")
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
