//
//  ContentView.swift
//  TestTaller
//
//  Created by Gabriel Patané Todaro on 09/05/24.
//

import SwiftUI

/**

 Challenge
 Create a simple iOS app with Swift that fetches data from a public API and displays it in a list.

 Requirements
 Use the JSONPlaceholder API: https://jsonplaceholder.typicode.com/
 Loop through 10 itens and display a list of posts. URL example: https://jsonplaceholder.typicode.com/posts/1
 Fetch data from the API using URLSession or Alamofire
 Perform network operations asynchronously to avoid blocking the main UI thread and maintain a smooth user experience
 Display the fetched data in a UITableView or UICollectionView
 Each item in the list should display at least two pieces of information from the API response (e.g., title and body for posts)
 (Optional) When an item in the list is clicked, display a detail view with more information about the selected item

 */

struct ContentView: View {
	@StateObject var viewModel = ViewModel()

    var body: some View {
		switch viewModel.loadingState {
		case .idle:
			Text("Hello")
				.onAppear() {
					Task {
						try await viewModel.loadPosts()
					}
				}

		case .loading:
			ProgressView()

		case .loaded(let posts):
			NavigationStack {
				List(posts) { post in
					NavigationLink(value: post) { Text(post.title ?? "Error") }
				}
				.navigationTitle("Posts")
				.navigationDestination(for: Post.self) { post in
					DetailView(title: post.title ?? "Error", 
							   bodyText: post.body ?? "Error")
				}
			}
		}
    }
}

#Preview {
    ContentView()
}
