Shader "Raymarching/111"
{

Properties
{
    [Header(PBS)]
    _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    _Metallic("Metallic", Range(0.0, 1.0)) = 0.5
    _Glossiness("Smoothness", Range(0.0, 1.0)) = 0.5

    [Header(Pass)]
    [Enum(UnityEngine.Rendering.CullMode)] _Cull("Culling", Int) = 2

    [Header(Raymarching)]
    _Loop("Loop", Range(1, 100)) = 30
    _MinDistance("Minimum Distance", Range(0.001, 0.1)) = 0.01
    _DistanceMultiplier("Distance Multiplier", Range(0.001, 2.0)) = 1.0

// @block Properties
// _Color2("Color2", Color) = (1.0, 1.0, 1.0, 1.0)
_SphereSize("SphereSize", Range(0, 10)) = 6.0
_Smooth("Smooth", Range(0, 10)) = 6.0
_Offset1("Offset1", Vector) = (0.0,1.0,0.0)
_Offset2("Offset2", Vector) = (0.0,-1.0,0.0)
_BoxParam("BoxParam", Vector) = (0.0,0.0,0.0)
// @endblock
}

SubShader
{

Tags
{
    "RenderType" = "Opaque"
    "Queue" = "Geometry"
    "DisableBatching" = "True"
}

Cull [_Cull]

CGINCLUDE

#define OBJECT_SHAPE_CUBE

#define USE_RAYMARCHING_DEPTH

#define SPHERICAL_HARMONICS_PER_PIXEL

#define DISTANCE_FUNCTION DistanceFunction
#define POST_EFFECT PostEffect
#define PostEffectOutput SurfaceOutputStandard

#include "Assets/uRaymarching/Shaders/Include/Common.cginc"

// @block DistanceFunction
float3 _Offset1;
float3 _Offset2;
float _SphereSize;
float _Smooth;

float3 trans(float3 p){
return fmod(p, 4.0) - 2.0;
}

float smoothMin(float d1, float d2, float k){
    float h = exp(-k * d1) + exp(-k * d2);
    return -log(h) / k;
} 

float sdBox( float3 p)
{
    float3 q = abs(p);
    return length(max(q - float3(0.2, 0.2, 0.2), 0.0));
}

float Sphere1 (float3 p){
 return length(p+_Offset1) - _SphereSize;
}

float Sphere2(float3 p){
 return length(p+_Offset2) - _SphereSize;
}

inline float DistanceFunction(float3 pos)
{
_Smooth = 3.2 + sin(_Time*30.0+1.0)*2.4;

float3 p = trans(pos);
 float s1 = Sphere1 (pos);
 float s2 = Sphere2 (pos);
float b1 = sdBox(pos);
 //return Sphere1 (pos);
 // return  min(s1,s2);
 return smoothMin(smoothMin(s1,s2,_Smooth),b1, 9.0);
}
// @endblock

// @block PostEffect
inline void PostEffect(RaymarchInfo ray, inout PostEffectOutput o)
{
}
// @endblock

ENDCG

Pass
{
    Tags { "LightMode" = "Deferred" }

    Stencil
    {
        Comp Always
        Pass Replace
        Ref 128
    }

    CGPROGRAM
    #include "Assets/uRaymarching/Shaders/Include/DeferredStandard.cginc"
    #pragma target 3.0
    #pragma vertex Vert
    #pragma fragment Frag
    #pragma exclude_renderers nomrt
    #pragma multi_compile_prepassfinal
    #pragma multi_compile ___ UNITY_HDR_ON
    ENDCG
}

}

Fallback "Raymarching/Fallbacks/StandardSurfaceShader"

CustomEditor "uShaderTemplate.MaterialEditor"

}