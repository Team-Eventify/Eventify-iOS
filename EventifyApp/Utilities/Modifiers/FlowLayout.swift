//
//  FlowLayout.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 13.07.2024.
//

import SwiftUI

struct FlowLayout: Layout {
	private let horizontalSpacing: CGFloat
	private let verticalSpacing: CGFloat

	init(horizontalSpacing: CGFloat = 0, verticalSpacing: CGFloat = 0) {
		self.horizontalSpacing = horizontalSpacing
		self.verticalSpacing = verticalSpacing
	}

	func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
		let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
		let maxLineHeight = sizes.compactMap { $0.height }.max() ?? 0

		var totalHeight: CGFloat = 0
		var totalWidth: CGFloat = 0

		var lineWidth: CGFloat = 0

		for size in sizes {
			if lineWidth + size.width + horizontalSpacing > proposal.width ?? 0 {
				totalHeight += maxLineHeight + verticalSpacing
				lineWidth = size.width
			} else {
				lineWidth += size.width + horizontalSpacing
			}

			totalWidth = max(totalWidth, lineWidth)
		}

		totalHeight += maxLineHeight + verticalSpacing

		return .init(width: totalWidth, height: totalHeight)
	}

	func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
		let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
		let maxLineHeight = sizes.compactMap { $0.height }.max() ?? 0

		var lineX = bounds.minX
		var lineY = bounds.minY

		for index in subviews.indices {
			if lineX + sizes[index].width + horizontalSpacing > (proposal.width ?? 0) {
				lineY += maxLineHeight + verticalSpacing
				lineX = bounds.minX
			}

			subviews[index].place(
				at: .init(
					x: lineX + sizes[index].width / 2,
					y: lineY + maxLineHeight / 2
				),
				anchor: .center,
				proposal: ProposedViewSize(sizes[index])
			)

			lineX += sizes[index].width + horizontalSpacing
		}
	}
}

#Preview {
	FlowLayout(horizontalSpacing: 15, verticalSpacing: 10) {
		ForEach(0..<5) { _ in
			Group {
				Text("Hello")
					.font(.largeTitle)
				Text("World")
					.font(.title)
				Text("!!!")
					.font(.title3)
			}
			.border(Color.red)
		}
	}
}
