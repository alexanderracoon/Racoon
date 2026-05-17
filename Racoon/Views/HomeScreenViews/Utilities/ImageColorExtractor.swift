//
//  ImageColorExtractor.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.05.2026.
//

import SwiftUI
import CoreImage
import ImageIO
import CoreImage.CIFilterBuiltins

enum ImageColorExtractor {
    private static let context = CIContext()

    static func averageColor(from url: URL?) -> Color? {
        guard let url = url else { return .orange }
        
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil)
        else {
            return nil
        }

        let ciImage = CIImage(cgImage: cgImage)
        let extent = ciImage.extent

        let filter = CIFilter.areaAverage()
        filter.inputImage = ciImage
        filter.extent = extent

        guard let outputImage = filter.outputImage else {
            return nil
        }

        var bitmap = [UInt8](repeating: 0, count: 4)

        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )

        return Color(
            red: Double(bitmap[0]) / 255.0,
            green: Double(bitmap[1]) / 255.0,
            blue: Double(bitmap[2]) / 255.0,
            opacity: Double(bitmap[3]) / 255.0
        )
    }
}
