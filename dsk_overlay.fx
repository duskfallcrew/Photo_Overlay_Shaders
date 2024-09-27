#pragma target 3.0
#pragma shader pixel

#include "ReShade.fxh"

// Define the texture samplers
uniform sampler2D textureSampler : register(s0) = sampler_state {
    Texture = (textureFile);
};
uniform sampler2D overlayTexture : register(s1) = sampler_state {
    Texture = (textureFile);
};

// Define the blending mode variable
uniform int blendMode = 0;

// Define the main shader function
float4 main(float2 uv : TEXCOORD) : COLOR
{
    // Sample the texture
    float4 textureColor = tex2Dlod(textureSampler, float4(uv, 0, 0));

    // Sample the overlay texture
    float4 overlayColor = tex2Dlod(overlayTexture, float4(uv, 0, 0));

    // Apply the blend mode
    float4 blendedColor;
    if (blendMode == 0) blendedColor = textureColor * overlayColor; // Multiply
    else if (blendMode == 1) blendedColor = 1.0 - (1.0 - textureColor) * (1.0 - overlayColor); // Screen
    //... add more blending modes here...

    // Return the final color
    return blendedColor;
}

// Define the technique
technique Dusk's Photo Overlay < ui_tooltip = "A photo-like overlay effect created by Dusk."; >
{
    pass p0
    {
        VertexShader = VSMain;
        PixelShader = main;
    }
}

// Define the UI for the blending mode
ui "Blending Mode" Combo Box {
    "Multiply" = 0,
    "Screen" = 1,
    "Overlay" = 2,
    "SoftLight" = 3,
    "HardLight" = 4,
    "ColorDodge" = 5,
    "ColorBurn" = 6,
    "LinearDodge" = 7,
    "LinearBurn" = 8,
    "VividLight" = 9,
    "LinearLight" = 10,
    "PinLight" = 11,
    "HardMix" = 12
}
