//
//  DetailView.swift
//  TestTaller
//
//  Created by Gabriel Patané Todaro on 09/05/24.
//

import SwiftUI

struct DetailView: View {
	let title: String
	let bodyText: String

	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				Text(title)
					.font(.largeTitle)
					.padding(.bottom)

				Text(bodyText)
					.font(.body)
			}
		}
		.padding()
	}
}
