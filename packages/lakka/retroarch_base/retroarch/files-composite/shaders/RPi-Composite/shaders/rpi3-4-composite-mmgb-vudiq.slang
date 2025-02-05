#version 450

// Implementation based on the article "Efficient Gaussian blur with linear sampling"
// http://rastergrid.com/blog/2010/09/efficient-gaussian-blur-with-linear-sampling/
/* A version for MasterEffect Reborn, a standalone version, and a custom shader version for SweetFX can
   found at http://reshade.me/forum/shader-presentation/27-gaussian-blur-bloom-unsharpmask */
 /*-----------------------------------------------------------.
/                  Gaussian Blur settings                     /
'-----------------------------------------------------------*/

// This shader is based on blur-gauss-h.slang, modified by Vudiq and inspired by MegaManGB
// for use with Lakka's special version made for the analog video output of the Raspberry Pi 5.

layout(push_constant) uniform Push
{
   vec4 SourceSize;
   vec4 OriginalSize;
   vec4 OutputSize;
   uint FrameCount;
} params;

#define InputSize params.SourceSize.xy
#define TextureSize params.SourceSize.xy

layout(std140, set = 0, binding = 0) uniform UBO
{
   mat4 MVP;
} global;

#define HW 0.28

#pragma stage vertex
layout(location = 0) in vec4 Position;
layout(location = 1) in vec2 TexCoord;
layout(location = 0) out vec2 vTexCoord;

void main()
{
   gl_Position = global.MVP * Position;
   vTexCoord = TexCoord;
}

#pragma stage fragment
layout(location = 0) in vec2 vTexCoord;
layout(location = 0) out vec4 FragColor;
layout(set = 0, binding = 2) uniform sampler2D Source;

void main()
{
   vec2 texcoord  = vTexCoord;
   
   vec4 SourceSize;

   if (InputSize.x > 400.0)
      SourceSize = vec4(TextureSize, 88.0 / TextureSize);
   else if (InputSize.x > 300.0)
      SourceSize = vec4(TextureSize, 54.38 / TextureSize);
   else if (InputSize.x > 250.0)
      SourceSize = vec4(TextureSize, 40.0 / TextureSize);
   else if (InputSize.x > 200.0)
      SourceSize = vec4(TextureSize, 45.0 / TextureSize);
   else
      SourceSize = vec4(TextureSize, 40.0 / TextureSize);

   vec2 PIXEL_SIZE = SourceSize.zw;

   float sampleOffsets[5] = {
      0.01,
      0.02,
      0.03,
      0.04,
      0.05
      };

   float sampleWeight = 0.09;

   vec4 color = texture(Source, texcoord) * sampleWeight;
   for(int i = 0; i < 5; ++i) {
      color += texture(Source, texcoord + vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeight;
      color += texture(Source, texcoord - vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeight;
   }
   FragColor = vec4(color);
}
