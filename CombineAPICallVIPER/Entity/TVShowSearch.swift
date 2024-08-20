import Foundation

struct TVShowSearch: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Codable, Identifiable, Equatable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let firstAirDate, name: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    // Equatable conformance
       static func == (lhs: Result, rhs: Result) -> Bool {
           return lhs.id == rhs.id &&
                  lhs.adult == rhs.adult &&
                  lhs.backdropPath == rhs.backdropPath &&
                  lhs.genreIDS == rhs.genreIDS &&
                  lhs.originCountry == rhs.originCountry &&
                  lhs.originalLanguage == rhs.originalLanguage &&
                  lhs.originalName == rhs.originalName &&
                  lhs.overview == rhs.overview &&
                  lhs.popularity == rhs.popularity &&
                  lhs.posterPath == rhs.posterPath &&
                  lhs.firstAirDate == rhs.firstAirDate &&
                  lhs.name == rhs.name &&
                  lhs.voteAverage == rhs.voteAverage &&
                  lhs.voteCount == rhs.voteCount
       }
}

