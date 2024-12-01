//
//  ShimmerEffect.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 08.10.2024.
//

import SwiftUI

extension View {
	@ViewBuilder
	func shimmer(
		isActive: Bool, configuration: ShimmerEffect.Configuration = .default
	) -> some View {
		if isActive {
			modifier(ShimmerEffect(configuration: configuration))
		} else {
			self
		}
	}

	@ViewBuilder
	func shimmer(
		ifNil optional: Any?,
		configuration: ShimmerEffect.Configuration = .default
	) -> some View {
		if optional == nil {
			modifier(ShimmerEffect(configuration: configuration))
		} else {
			self
		}
	}
}

struct ShimmerEffect: ViewModifier {

	private var configuration: Configuration
	@State private var moveTo: CGFloat = -0.7

	init(configuration: Configuration) {
		self.configuration = configuration
	}

	func body(content: Content) -> some View {
		content
			.hidden()
			.overlay {
				Rectangle()
					.fill(configuration.tint)
					.mask {
						content
					}
					.overlay {
						GeometryReader {
							let size = $0.size
							let extraOffset =
								(size.height / 2.5) + configuration.blur

							Rectangle()
								.fill(configuration.highlight)
								.mask {
									Rectangle()
										.fill(
											.linearGradient(
												colors: [
													.white.opacity(0),
													configuration.highlight
														.opacity(
															configuration
																.highlightOpacity
														),
													.white.opacity(0),
												],
												startPoint: .top,
												endPoint: .bottom
											)
										)
										.blur(radius: configuration.blur)
										.rotationEffect(.init(degrees: -70))
										.offset(
											x: moveTo > 0
												? extraOffset : -extraOffset
										)
										.offset(x: size.width * moveTo)
								}
								.blendMode(configuration.blendMode)
						}
						.mask {
							content
						}
					}
					.onAppear {
						DispatchQueue.main.async {
							moveTo = 0.7
						}
					}
					.animation(
						.linear(duration: configuration.speed).repeatForever(
							autoreverses: false), value: moveTo)
			}
	}
}

// MARK: Configuration

extension ShimmerEffect {
	struct Configuration {
		var tint: Color
		var highlight: Color
		var blur: CGFloat
		var highlightOpacity: CGFloat = 1
		var speed: CGFloat = 2
		var blendMode: BlendMode = .normal
	}
}

extension ShimmerEffect.Configuration {
	static let `default` = Self(
		tint: .gray.opacity(0.3),
		highlight: .white,
		blur: 5
	)
}
