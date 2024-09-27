#include "ReShade.fxh"

// Define the texture samplers
uniform sampler2D textureSampler;
uniform sampler2D overlayTexture;

// Define the blending mode variable
uniform int blendMode = 0;

// Define the main shader function
float4 main(float2 uv) : COLOR
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

technique Standard
{
    pass P0
    {
        VertexShader = VS_Main;
        PixelShader = PS_Main;
    }
}

VertexShader = VS_Main
{
    float4 main(float4 position : POSITION) : SV_POSITION
    {
        return position;
    }
}

PixelShader = PS_Main
{
    float4 main(float2 uv) : COLOR
    {
        // Your shader code goes here
        return main(uv);
    }
}
