#include "ReShade.fxh"

texture2D textureSampler : TEXCOORD;
texture2D overlayTexture : TEXCOORD;

sampler2D samplerLinear
{
    Texture = textureSampler;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};

uniform int blendMode = 0;

float4 main(float2 uv : TEXCOORD) : SV_Target
{
    // Sample the texture
    float4 textureColor = samplerLinear.Sample(samplerLinear, uv);

    // Sample the overlay texture
    float4 overlayColor = overlayTexture.Sample(samplerLinear, uv);

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
        VertexShader = PostProcessVS;
        PixelShader = main;
    }

    ui "Blending Mode" Combo Box
    {
        " Multiply" = 0,
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
