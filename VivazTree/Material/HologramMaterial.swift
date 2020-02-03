//
//  HologramMaterial.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 31/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit

class HologramMaterial: SCNMaterial {
    var backgroundColor: UIColor = .green {
        didSet { didSetBackgroundColor() }
    }

    var thresholdSensitivity: Float = 0.5 {
        didSet { didSetThresholdSensitivity() }
    }

    var smoothing: Float = 0.001 {
        didSet { didSetSmoothing() }
    }

    override init() {
        super.init()

        didSetBackgroundColor()
        didSetThresholdSensitivity()
        didSetSmoothing()

        // chroma key shader is based on GPUImage
        // https://github.com/BradLarson/GPUImage/blob/master/framework/Source/GPUImageChromaKeyFilter.m

        let surfaceShader =
            """
            uniform vec3 c_colorToReplace;
            uniform float c_thresholdSensitivity;
            uniform float c_smoothing;

            #pragma transparent
            #pragma body

            vec3 textureColor = _surface.diffuse.rgb;

            float maskY = 0.2989 * c_colorToReplace.r + 0.5866 * c_colorToReplace.g + 0.1145 * c_colorToReplace.b;
            float maskCr = 0.7132 * (c_colorToReplace.r - maskY);
            float maskCb = 0.5647 * (c_colorToReplace.b - maskY);

            float Y = 0.2989 * textureColor.r + 0.5866 * textureColor.g + 0.1145 * textureColor.b;
            float Cr = 0.7132 * (textureColor.r - Y);
            float Cb = 0.5647 * (textureColor.b - Y);

            float blendValue = smoothstep(c_thresholdSensitivity, c_thresholdSensitivity + c_smoothing, distance(vec2(Cr, Cb), vec2(maskCr, maskCb)));

            float a = blendValue;
            _surface.transparent.a = a;
            """

        let fragmentShader =
            """
            _output.color.rgb = vec3(0.3, 0.5, 1.0) * _output.color.rgb;
            if (_output.color.a == 1.0) {
                _output.color.a = 0.95;
            }
            """
        
        shaderModifiers = [
            .surface: surfaceShader,
            .fragment: fragmentShader,
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //setting background color to be keyed out
    private func didSetBackgroundColor() {
        //getting pixel from background color
        let rgb = backgroundColor.cgColor.components!.map { Float($0) }
        let vector = SCNVector3(x: rgb[0], y: rgb[1], z: rgb[2])
        setValue(vector, forKey: "c_colorToReplace")
    }

    private func didSetSmoothing() {
        setValue(smoothing, forKey: "c_smoothing")
    }

    private func didSetThresholdSensitivity() {
        setValue(thresholdSensitivity, forKey: "c_thresholdSensitivity")
    }
}
