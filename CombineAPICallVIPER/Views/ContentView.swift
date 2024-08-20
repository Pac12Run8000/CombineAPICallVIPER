import SwiftUI

struct ContentView: View {
    @ObservedObject var presenter: TVShowSearchPresenter  // Use the concrete type
    @State private var searchText = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .padding(AppStyles.textFieldPadding)
                    .background(AppColors.lightGrayColor)
                    .cornerRadius(AppStyles.cornerRadius)
                    .foregroundColor(AppColors.blackColor)

                Button(action: {
                    presenter.searchTVShows(query: searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(AppStyles.buttonPadding)
                        .background(AppColors.blueColor)
                        .foregroundColor(AppColors.whiteColor)
                        .cornerRadius(AppStyles.cornerRadius)
                }
            }
            .padding()
            .background(AppColors.darkColor)

            if let errorMessage = presenter.error?.localizedDescription {
                Spacer()
                Text(errorMessage)
                Spacer()
            } else if let results = presenter.tvShowSearch?.results, !results.isEmpty {
                List(results, id: \.id) { show in
                    VStack(alignment: .leading) {
                        Text(show.name)
                            .font(.headline)
                        Text(show.overview)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        presenter.didSelectShow(show)
                    }
                }
            } else {
                Spacer()
                Text("No Results")
                Spacer()
            }
        }
    }
}
