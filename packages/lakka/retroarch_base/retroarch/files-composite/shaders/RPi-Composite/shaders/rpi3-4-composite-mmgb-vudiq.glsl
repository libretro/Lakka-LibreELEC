// Implementation based on the article "Efficient Gaussian blur with linear sampling"
// http://rastergrid.com/blog/2010/09/efficient-gaussian-blur-with-linear-sampling/
/* A version for MasterEffect Reborn, a standalone version, and a custom shader version for SweetFX can be
   found at http://reshade.me/forum/shader-presentation/27-gaussian-blur-bloom-unsharpmask */
 /*-----------------------------------------------------------.
/                  Gaussian Blur settings                     /
'-----------------------------------------------------------*/

// This shader is based on blur-gauss-h.glsl, modified by MegaManGB and Vudiq
// for use with Lakka's special version made for the analog video output of Raspberry Pi 3 and 4.

#define HW 0.28

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying
#define COMPAT_ATTRIBUTE attribute
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;

vec4 _oPosition1;
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    COL0 = COLOR;
    TEX0.xy = TexCoord.xy;
}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;

// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define outsize vec4(OutputSize, 0.0 / OutputSize)

void main()
{
   vec2 texcoord  = vTexCoord;

   vec4 SourceSize;
   if (InputSize.x > 565.0)
      SourceSize = vec4(TextureSize, 107.0 / TextureSize);
   else if (InputSize.x > 450.0)
      SourceSize = vec4(TextureSize, 85.0 / TextureSize);
   else if (InputSize.x > 300.0)
      SourceSize = vec4(TextureSize, 54.38 / TextureSize);
   else if (InputSize.x > 250.0)
      SourceSize = vec4(TextureSize, 40.0 / TextureSize);
   else if (InputSize.x > 200.0)
      SourceSize = vec4(TextureSize, 45.0 / TextureSize);
   else
      SourceSize = vec4(TextureSize, 40.0 / TextureSize);

   vec2 PIXEL_SIZE = SourceSize.zw;

#if __VERSION__ < 130
   float sampleOffsets1 = 0.01;
   float sampleOffsets2 = 0.02;
   float sampleOffsets3 = 0.03;
   float sampleOffsets4 = 0.04;
   float sampleOffsets5 = 0.05;

   float sampleWeights1 = 0.09;
   float sampleWeights2 = 0.0;
   float sampleWeights3 = 0.0;
   float sampleWeights4 = 0.0;
   float sampleWeights5 = 0.0;

   vec4 color = COMPAT_TEXTURE(Source, texcoord) * sampleWeights1;

// unroll the loop
      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets1* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets1* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;

      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets2* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets2* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;

      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets3* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets3* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;

      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets4* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets4* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;

      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets5* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets5* HW * PIXEL_SIZE.x, 0.0)) * sampleWeights1;
#else

   float sampleOffsets[5] = { 0.01, 0.02, 0.03, 0.04, 0.05 }; // updated values here too
   float sampleWeights[5] = { 0.09, 0.0, 0.0, 0.0, 0.0 };

   vec4 color = COMPAT_TEXTURE(Source, texcoord) * sampleWeights[0];
   for(int i = 1; i < 5; ++i) {
      color += COMPAT_TEXTURE(Source, texcoord + vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeights[i];
      color += COMPAT_TEXTURE(Source, texcoord - vec2(sampleOffsets[i]*HW * PIXEL_SIZE.x, 0.0)) * sampleWeights[i];
   }
#endif

   FragColor = vec4(color);
}
#endif
