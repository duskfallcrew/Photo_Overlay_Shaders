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

sampler2D samplerLinearOverlay
{
    Texture = overlayTexture;
    AddressU = CLAMP;
    AddressV = CLAMP;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};

uniform int blendMode < ui_label = "Blending Mode"; ui_type = "combo"; ui_items = "Multiply\0Screen\0Overlay\0SoftLight\0HardLight\0ColorDodge\0ColorBurn\0LinearDodge\0LinearBurn\0VividLight\0LinearLight\0PinLight\0HardMix\0"; ui_tooltip = "Select a blending mode"; > = 0;

float4 main(float2 uv : TEXCOORD) : SV_Target
{
    float4 textureColor = tex2D(samplerLinear, uv);
    float4 overlayColor = tex2D(samplerLinearOverlay, uv);

    float4 blendedColor = textureColor;

    if (blendMode == 0) blendedColor = textureColor * overlayColor; // Multiply
    else if (blendMode == 1) blendedColor = 1.0 - (1.0 - textureColor) * (1.0 - overlayColor); // Screen
    else if (blendMode == 2) blendedColor = (textureColor < 0.5)? (2 * textureColor * overlayColor) : (1 - 2 * (1 - textureColor) * (1 - overlayColor)); // Overlay
    else if (blendMode == 3) blendedColor = (textureColor + overlayColor) - sqrt(textureColor * overlayColor); // SoftLight
    else if (blendMode == 4) blendedColor = (textureColor < 0.5)? (textureColor * 2 * overlayColor) : (1 - 2 * (1 - textureColor) * (1 - overlayColor)); // HardLight
    else if (blendMode == 5) blendedColor = textureColor / (1 - overlayColor); // ColorDodge
    else if (blendMode == 6) blendedColor = 1 - (1 - textureColor) / overlayColor; // ColorBurn
    else if (blendMode == 7) blendedColor = textureColor + overlayColor; // LinearDodge
    else if (blendMode == 8) blendedColor = textureColor + overlayColor - 1; // LinearBurn
    else if (blendMode == 9) blendedColor = 1 - (1 - textureColor) / overlayColor; // VividLight
    else if (blendMode == 10) blendedColor = (textureColor < 0.5)? (textureColor + 2 * overlayColor * textureColor) : (textureColor + 2 * overlayColor - 2 * textureColor * overlayColor); // LinearLight
    else if (blendMode == 11) blendedColor = (textureColor < 0.5)? (2 * textureColor * overlayColor) : (1 - 2 * (1 - textureColor) * (1 - overlayColor)); // PinLight
    else if (blendMode == 12) blendedColor = (textureColor < 0.5)? (2 * textureColor * (1 - overlayColor)) : (1 - 2 * (1 - textureColor) * overlayColor); // HardMix

    return blendedColor;
}

technique DuskPhotoOverlay
{
    pass p0
    {
        VertexShader = PostProcessVS;
        PixelShader = main;
    }
}
