#include "ReShade.fxh"

// Define the texture samplers
sampler2D textureSampler : register(s0);
sampler2D overlayTexture : register(s1);

// Define the blending mode variable
uniform int blendMode = 0;

// Define the blending mode function
float4 blend(float4 src, float4 dst)
{
    if (blendMode == 0) return src * dst; // Multiply
    else if (blendMode == 1) return 1.0 - (1.0 - src) * (1.0 - dst); // Screen
    //... add more blending modes here...
}

// Define the main shader function
float4 main(float2 uv : TEXCOORD) : COLOR
{
    // Sample the texture
    float4 textureColor = tex2D(textureSampler, uv);

    // Sample the overlay texture
    float4 overlayColor = tex2D(overlayTexture, uv);

    // Apply the blend mode
    float4 blendedColor = blend(textureColor, overlayColor);

    // Apply the effect strength
    blendedColor *= effectStrength;

    // Return the final color
    return blendedColor;
}

// Define the UI for the blending mode
uniform float effectStrength = 1.0;
uniform string textureFile = "";
uniform bool retainAspectRatio = true;

// Define the UI for the blending mode
ui "Blending Mode" Combo Box {
    "Multiply",
    "Screen",
    "Overlay",
    "SoftLight",
    "HardLight",
    "ColorDodge",
    "ColorBurn",
    "LinearDodge",
    "LinearBurn",
    "VividLight",
    "LinearLight",
    "PinLight",
    "HardMix"
}
