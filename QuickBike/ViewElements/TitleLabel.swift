//
//  TitleLabel.swift
//  QuickBike
//
//  Created by Urs Privat on 25.07.21.
//

import SwiftUI
import Rswift

struct TitleLabel: View {
	var body: some View {

		HStack {
			Text("Quick")
				.font(.largeTitle)
				.padding(.top, 4)
			Image(systemName: "bicycle")
				.resizable()
				.frame(width: 50, height: 30, alignment: .center)
		}
		.padding(.top)
	}
}

struct TitleLabel_Previews: PreviewProvider {
	static var previews: some View {
		TitleLabel()
	}
}
