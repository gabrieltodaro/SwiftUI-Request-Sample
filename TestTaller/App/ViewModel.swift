//
//  ViewModel.swift
//  TestTaller
//
//  Created by Gabriel Patané Todaro on 09/05/24.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
	enum LoadingState {
		case idle
		case loading
		case loaded([Post])
	}

	private let rootUrl = "https://jsonplaceholder.typicode.com/posts"

	@Published var loadingState = LoadingState.idle

	func loadPosts() async throws {

		loadingState = .loading

		let request = URLRequest(url: URL(string: rootUrl)!)

		let session = URLSession(configuration: .default)
		do {
			let (data, _) = try await session.data(for: request)

			let response = try JSONDecoder().decode([Post].self, from: data)
			DispatchQueue.main.async {
				self.loadingState = .loaded(response)
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	private func load10Posts() async throws {
		var postsInScope: [Post] = []

		loadingState = .loading

		for index in 1...10 {
			let url = URL(string: "\(rootUrl)/\(index)")!
			let request = URLRequest(url: url)

			let session = URLSession(configuration: .default)
			do {
				let (data, _) = try await session.data(for: request)

				let response = try JSONDecoder().decode(Post.self, from: data)
				postsInScope.append(response)
			} catch {
				print(error.localizedDescription)
			}
		}

		DispatchQueue.main.async {
			self.loadingState = .loaded(postsInScope)
		}
	}
}
