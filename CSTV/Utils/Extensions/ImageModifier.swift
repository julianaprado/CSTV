//
//  ImageModifier.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI

// Image Modifiers
extension Image {
    
    /// Image Modifiers
    /// - Returns: View with basic reused modifiers
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    /// Team Modifiers
    /// - Returns: View with modifiers for the Team images
    func teamModifier() -> some View {
        self
            .imageModifier()
            .frame(width: 53, height: 60)
            .clipped()
            .aspectRatio(contentMode: .fill)
    }
    
    /// Icon Modifiers
    /// - Returns: View with modifiers for the icons used in case the team images return errors
    func iconModifier() -> some View {
        self
            .teamModifier()
            .foregroundColor(.gray)
    }
    
    /// League Icon Modifiers
    /// - Returns: View with modifiers for the icons used in case the league images return errors
    func leagueIconModifier() -> some View {
        self
            .leagueModifier()
            .foregroundColor(.gray)
    }
    
    /// League Modifiers
    /// - Returns:View with modifiers for the league images
    func leagueModifier() -> some View {
        self
            .imageModifier()
            .aspectRatio(contentMode: .fill)
            .frame(width: 14, height: 14)
    }
    
    /// Player Modifiers
    /// - Returns: View with modifiers for the player images
    /// TODO: Apply ML to get attention-based saliency (VNGenerateAttentionBasedSaliencyImageRequest)
    func playerModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.gray)
    }
    
}
