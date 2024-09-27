#include "ReShade.fxh"

// Define the texture samplers
sampler2D textureSampler : register(s0);
sampler2D overlayTexture : register(s1);

// Define the blending modes
enum BlendMode : int {
    Multiply,
    Screen,
    Overlay,
    SoftLight,
    HardLight,
    ColorDodge,
    ColorBurn,
    LinearDodge,
    LinearBurn,
    VividLight,
    LinearLight,
    PinLight,
    HardMix
};

// Define the blending mode function
float4 blendModeFunction(float4 src, float4 dst, BlendMode mode)
{
    //... (rest of the blend mode function remains the same)
}

// Define the main shader function
float4 main(float2 uv : TEXCOORD) : COLOR
{
    // Sample the texture
    float4 textureColor = tex2D(textureSampler, uv);

    // Sample the overlay texture
    float4 overlayColor = tex2D(overlayTexture, uv);

    // Apply the blend mode
    float4 blendedColor = blendModeFunction(textureColor, overlayColor, blendMode);

    // Apply the effect strength
    blendedColor *= effectStrength;

    // Return the final color
    return blendedColor;
}

// Define the UI for the blending mode
uniform BlendMode blendMode = Multiply;
uniform float effectStrength = 1.0;
uniform string textureFile = "";
uniform bool retainAspectRatio = true;
