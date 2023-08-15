//
//  ViewCornerRadius.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI

// Custom Corner Radius Function
/// SwiftUi Still doesn't support applying corners radius on specific corners:
/// ex., .cornerRadius[.topRight, .bottomLeft]
/// TODO: Remove when there is an update
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    /// Custom Corner Radius
    /// - Parameters:
    ///   - radius: radius value to be applied
    ///   - corners: which corner to apply radius
    /// - Returns: shape with corners radius to clip view by
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
