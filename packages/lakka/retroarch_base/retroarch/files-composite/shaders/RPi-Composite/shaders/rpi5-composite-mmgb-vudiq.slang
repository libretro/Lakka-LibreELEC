#version 450

// Implementation based on the article "Efficient Gaussian blur with linear sampling"
// http://rastergrid.com/blog/2010/09/efficient-gaussian-blur-with-linear-sampling/
/* A version for MasterEffect Reborn, a standalone version, and a custom shader version for SweetFX can be
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

#define HW 4.40

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

   if (InputSize.x > 565.0)
      SourceSize = vec4(TextureSize, 1880.0 / TextureSize);
   else if (InputSize.x > 450.0)
      SourceSize = vec4(TextureSize, 900.0 / TextureSize);
   else if (InputSize.x > 300.0)
      SourceSize = vec4(TextureSize, 850.0 / TextureSize);
   else if (InputSize.x > 250.0)
      SourceSize = vec4(TextureSize, 295.0 / TextureSize);
   else if (InputSize.x > 200.0)
      SourceSize = vec4(TextureSize, 400.0 / TextureSize);
   else
      SourceSize = vec4(TextureSize, 295.0 / TextureSize);

   vec2 PIXEL_SIZE = SourceSize.zw;

   float sampleOffsets[15] = {
      0.00001,
      0.00002,
      0.00003,
      0.00004,
      0.00005,
      0.00006,
      0.00007,
      0.00008,
      0.00009,
      0.00010,
      0.00011,
      0.00012,
      0.00013,
      0.00014,
      0.00015
      };

   float sampleWeight = 0.03200000;

   vec4 color = texture(Source, texcoord) * sampleWeight;
   for(int i = 0; i < 15; ++i) {
      color += texture(Source, texcoord + vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeight;
      color += texture(Source, texcoord - vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeight;
   }
   FragColor = vec4(color);
}
