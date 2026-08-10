Shader "Custom/MobileOcclusion"
{
    SubShader
    {
        // Render immediately before normal opaque geometry so the occlusion
        // mesh primes the depth buffer without forcing target materials to be
        // transparent.
        Tags
        {
            "RenderPipeline" = "UniversalPipeline"
            "Queue" = "Geometry-1"
            "RenderType" = "Opaque"
        }

        Pass
        {
            Name "OcclusionDepth"
            Tags { "LightMode" = "SRPDefaultUnlit" }

            ZWrite On
            ZTest LEqual
            ColorMask 0
            Cull Off

            HLSLPROGRAM
            #pragma target 2.0
            #pragma vertex Vert
            #pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
            };

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                return output;
            }

            half4 Frag(Varyings input) : SV_Target
            {
                return 0;
            }
            ENDHLSL
        }
    }

    Fallback Off
}
