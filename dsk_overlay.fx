#include "ReShade.fxh"

uniform sampler2D textureSampler;
uniform sampler2D overlayTexture;

uniform int blendMode = 0;

float4 main(float2 uv) : SV_Target
{
    // Sample the texture
    float4 textureColor = tex2D(textureSampler, uv);

    // Sample the overlay texture
    float4 overlayColor = tex2D(overlayTexture, uv);

    // Apply the blend mode
    float4 blendedColor;
    if (blendMode == 0) blendedColor = textureColor * overlayColor; // Multiply
    else if (blendMode == 1) blendedColor = 1.0 - (1.0 - textureColor) * (1.0 - overlayColor); // Screen
    //... add more blending modes here...

    // Return the final color
    return blendedColor;
}

technique DuskPhotoOverlay
{
    pass p0
    {
        PixelShader = main;
    }

    // Define the UI elements here
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
}
