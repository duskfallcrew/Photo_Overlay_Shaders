// ReShade Shader by Duskfallcrew @ Earth & Dusk

// Define the texture samplers
sampler2D textureSampler : register(s0);
sampler2D overlayTexture : register(s1);

// Define the blending modes
enum BlendMode {
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

// Define the blending mode variable
BlendMode blendMode = Multiply;

// Define the effect strength variable
float effectStrength = 1.0;
ui EffectStrength "Effect Strength" slider(0.0, 2.0, 0.1);

// Define the texture file variable
string textureFile = "";
ui textureFile "Texture File" File;

// Define the retain aspect ratio variable
bool retainAspectRatio = true;

// Define the main shader function
float4 main(float2 uv : TEXCOORD) : COLOR
{
    // Sample the texture
    float4 textureColor = tex2D(textureSampler, uv);

    // Sample the overlay texture
    float4 overlayColor = tex2D(overlayTexture, uv);

    // Define the blend mode function
    float4 blendModeFunction(float4 src, float4 dst)
    {
        //... (rest of the blend mode function remains the same)
    }

    // Apply the blend mode
    float4 blendedColor = blendModeFunction(textureColor, overlayColor);

    // Apply the effect strength
    blendedColor *= effectStrength;

    // Return the final color
    return blendedColor;
}

// Define the UI for the blending mode
ui BlendMode "Blending Mode" Combo Box {
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
};
