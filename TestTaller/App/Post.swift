//
//  Post.swift
//  TestTaller
//
//  Created by Gabriel Patané Todaro on 09/05/24.
//

import Foundation

struct Post: Identifiable, Hashable, Decodable {
	let id: Int
	let userId: Int
	let title: String?
	let body: String?
}
