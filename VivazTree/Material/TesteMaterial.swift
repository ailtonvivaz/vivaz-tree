//
//  TesteMaterial.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 30/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import SceneKit

public class TesteMaterial: SCNMaterial {
    public init(backgroundColor: UIColor = .green, thresholdSensitivity: Float = 0.50, smoothing: Float = 0.001) {
        super.init()

        // chroma key shader is based on GPUImage
        // https://github.com/BradLarson/GPUImage/blob/master/framework/Source/GPUImageChromaKeyFilter.m

        let surfaceShader =
            """
            #pragma arguments

             float revealage;
             texture2d<float, access::sample> noiseTexture;

             #pragma transparent
             #pragma body

             const float edgeWidth = 0.02;
             const float edgeBrightness = 2;
             const float3 innerColor = float3(0.4, 0.8, 1);
             const float3 outerColor = float3(0, 0.5, 1);
             const float noiseScale = 3;

             constexpr sampler noiseSampler(filter::linear, address::repeat);
             float2 noiseCoords = noiseScale * _surface.ambientTexcoord;
             float noiseValue = noiseTexture.sample(noiseSampler, noiseCoords).r;

             if (noiseValue > revealage) {
                 discard_fragment();
             }

             float edgeDist = revealage - noiseValue;
             if (edgeDist < edgeWidth) {
                 float t = edgeDist / edgeWidth;
                 float3 edgeColor = edgeBrightness * mix(outerColor, innerColor, t);
                 _output.color.rgb = edgeColor;
             }
            """

        //_surface.transparent.a = a;

        shaderModifiers = [
            .fragment: surfaceShader,
        ]
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
