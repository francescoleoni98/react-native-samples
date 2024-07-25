//
//  RainbowScrollView.swift
//
//  License: https://github.com/francescoleoni98/react-native-samples/blob/main/LICENSE.md
//  Created by Francesco Leoni on 15/07/24.
//

// YouTube video here: https://www.youtube.com/shorts/6R6BcSBBatE

import SwiftUI

struct RainbowScrollView: View {

	@State var opacity: CGFloat = 1.5
	@State var rotation: CGFloat = 1.5
	@State var colorDividend: CGFloat = 2

	var body: some View {
		GeometryReader { proxy in
			ScrollView(showsIndicators: false) {
				HStack {
					Section(color: .cyan, height: 30, mainProxy: proxy, multiplier: 1)
					Section(color: .cyan, height: 30, mainProxy: proxy, multiplier: -1)
					Section(color: .cyan, height: 30, mainProxy: proxy, multiplier: 1)
					Section(color: .cyan, height: 30, mainProxy: proxy, multiplier: -1)
				}
			}
		}
	}

	@ViewBuilder
	func Section(color: Color, height: CGFloat, mainProxy: GeometryProxy, multiplier: CGFloat) -> some View {
		VStack(spacing: 0) {
			ForEach(0...100, id: \.self) { _ in
				RoundedRectangle(cornerRadius: 25)
					.fill(color)
					.frame(height: height)
					.visualEffect { content, geometryProxy in
						content
							.rotationEffect(.degrees(multiplier * (geometryProxy.frame(in: .global).origin.y / rotation)), anchor: .center)
							.hueRotation(.degrees(geometryProxy.frame(in: .global).origin.y / colorDividend))
							.opacity(opacity(frame: geometryProxy.frame(in: .global), height: mainProxy.frame(in: .global).height))
					}
			}
		}
	}

	func opacity(frame: CGRect, height: CGFloat) -> CGFloat {
		let half = height / 2
		return abs(opacity - (abs(frame.origin.y - half) / half))
	}
}

#Preview {
	RainbowScrollView()
}
