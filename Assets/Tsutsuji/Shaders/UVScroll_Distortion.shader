// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32898,y:32650,varname:node_4795,prsc:2|emission-2393-OUT,alpha-8346-OUT,refract-7134-OUT;n:type:ShaderForge.SFN_Tex2d,id:6074,x:32170,y:32457,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:_MainTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:caf01fcdeb0086e45b859ff0105589db,ntxv:0,isnm:False|UVIN-3651-OUT;n:type:ShaderForge.SFN_Multiply,id:2393,x:32481,y:32688,varname:node_2393,prsc:2|A-8905-OUT,B-5293-RGB;n:type:ShaderForge.SFN_Color,id:797,x:32170,y:32613,ptovrint:True,ptlb:Color,ptin:_TintColor,varname:_TintColor,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_TexCoord,id:6112,x:31539,y:32582,varname:node_6112,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:1770,x:31215,y:32635,varname:node_1770,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1934,x:31444,y:32722,varname:node_1934,prsc:2|A-1770-T,B-6534-OUT;n:type:ShaderForge.SFN_Slider,id:6534,x:31058,y:32812,ptovrint:False,ptlb:ScrollX,ptin:_ScrollX,varname:_ScrollX,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2.052482,max:10;n:type:ShaderForge.SFN_Multiply,id:4964,x:31511,y:32872,varname:node_4964,prsc:2|A-1770-T,B-5922-OUT;n:type:ShaderForge.SFN_Slider,id:5922,x:31184,y:32983,ptovrint:False,ptlb:ScrollY,ptin:_ScrollY,varname:_ScrollY,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:0,max:10;n:type:ShaderForge.SFN_Append,id:5138,x:31682,y:32747,varname:node_5138,prsc:2|A-1934-OUT,B-4964-OUT;n:type:ShaderForge.SFN_Add,id:3651,x:31996,y:32645,varname:node_3651,prsc:2|A-4104-OUT,B-5138-OUT;n:type:ShaderForge.SFN_Tex2d,id:5293,x:32209,y:32905,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:_Mask,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7591-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:7591,x:31996,y:32885,varname:node_7591,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Slider,id:3265,x:32062,y:32357,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:_Intensity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2,max:4;n:type:ShaderForge.SFN_Multiply,id:8905,x:32481,y:32403,varname:node_8905,prsc:2|A-3265-OUT,B-6074-RGB,C-797-RGB,D-3793-RGB;n:type:ShaderForge.SFN_VertexColor,id:3793,x:32185,y:32758,varname:node_3793,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:5441,x:31496,y:32199,ptovrint:False,ptlb:Noise,ptin:_Noise,varname:_Noise,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-3108-OUT;n:type:ShaderForge.SFN_Lerp,id:4104,x:31802,y:32515,varname:node_4104,prsc:2|A-6112-UVOUT,B-7237-OUT,T-5575-OUT;n:type:ShaderForge.SFN_Slider,id:3380,x:31310,y:32387,ptovrint:False,ptlb:NoisePower,ptin:_NoisePower,varname:_NoisePower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:4;n:type:ShaderForge.SFN_Slider,id:5575,x:31418,y:32486,ptovrint:False,ptlb:NoiseAmount,ptin:_NoiseAmount,varname:_NoiseAmount,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Time,id:1928,x:30726,y:32173,varname:node_1928,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4028,x:30955,y:32260,varname:node_4028,prsc:2|A-1928-T,B-7395-OUT;n:type:ShaderForge.SFN_Slider,id:7395,x:30569,y:32350,ptovrint:False,ptlb:ScrollX_Noise,ptin:_ScrollX_Noise,varname:_ScrollX_Noise,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2.761199,max:10;n:type:ShaderForge.SFN_Multiply,id:6299,x:31022,y:32410,varname:node_6299,prsc:2|A-1928-T,B-4793-OUT;n:type:ShaderForge.SFN_Slider,id:4793,x:30695,y:32521,ptovrint:False,ptlb:ScrollY_Noise,ptin:_ScrollY_Noise,varname:_ScrollY_Noise,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:0,max:10;n:type:ShaderForge.SFN_Append,id:4766,x:31193,y:32285,varname:node_4766,prsc:2|A-4028-OUT,B-6299-OUT;n:type:ShaderForge.SFN_TexCoord,id:9357,x:31123,y:32087,varname:node_9357,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:3108,x:31328,y:32172,varname:node_3108,prsc:2|A-9357-UVOUT,B-4766-OUT;n:type:ShaderForge.SFN_Power,id:7237,x:31665,y:32317,varname:node_7237,prsc:2|VAL-5441-R,EXP-3380-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8346,x:32691,y:32773,varname:node_8346,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-5325-OUT;n:type:ShaderForge.SFN_Tex2d,id:5805,x:32358,y:33095,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:_NormalMap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a1480307c5211f140ad1cb05693225b3,ntxv:3,isnm:True|UVIN-9061-OUT;n:type:ShaderForge.SFN_Append,id:4131,x:32574,y:33095,varname:node_4131,prsc:2|A-5805-R,B-5805-G;n:type:ShaderForge.SFN_Multiply,id:7134,x:32718,y:33256,varname:node_7134,prsc:2|A-4131-OUT,B-7635-OUT;n:type:ShaderForge.SFN_Slider,id:7635,x:32179,y:33387,ptovrint:False,ptlb:Distortion,ptin:_Distortion,varname:_Distortion,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Time,id:5471,x:31521,y:33129,varname:node_5471,prsc:2;n:type:ShaderForge.SFN_Multiply,id:450,x:31750,y:33216,varname:node_450,prsc:2|A-5471-T,B-6677-OUT;n:type:ShaderForge.SFN_Slider,id:6677,x:31364,y:33306,ptovrint:False,ptlb:ScrollX_Normal,ptin:_ScrollX_Normal,varname:_ScrollX_Normal,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2.761199,max:10;n:type:ShaderForge.SFN_Append,id:3192,x:31988,y:33241,varname:node_3192,prsc:2|A-450-OUT,B-1545-OUT;n:type:ShaderForge.SFN_TexCoord,id:5262,x:31918,y:33043,varname:node_5262,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:9061,x:32123,y:33128,varname:node_9061,prsc:2|A-5262-UVOUT,B-3192-OUT;n:type:ShaderForge.SFN_Multiply,id:1545,x:31817,y:33366,varname:node_1545,prsc:2|A-5471-T,B-3554-OUT;n:type:ShaderForge.SFN_Slider,id:3554,x:31490,y:33477,ptovrint:False,ptlb:ScrollY_Normal,ptin:_ScrollY_Normal,varname:_ScrollY_Normal,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:0,max:10;n:type:ShaderForge.SFN_Clamp01,id:5325,x:32561,y:32896,varname:node_5325,prsc:2|IN-2393-OUT;proporder:6074-797-6534-5922-5293-3265-5441-3380-5575-7395-4793-5805-7635-6677-3554;pass:END;sub:END;*/

Shader "Tsutsuji/UVScroll_Distortion" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        [HDR]_TintColor ("Color", Color) = (1,1,1,1)
        _ScrollX ("ScrollX", Range(-10, 10)) = -2.052482
        _ScrollY ("ScrollY", Range(-10, 10)) = 0
        _Mask ("Mask", 2D) = "white" {}
        _Intensity ("Intensity", Range(0, 4)) = 2
        _Noise ("Noise", 2D) = "white" {}
        _NoisePower ("NoisePower", Range(0, 4)) = 1
        _NoiseAmount ("NoiseAmount", Range(0, 1)) = 0
        _ScrollX_Noise ("ScrollX_Noise", Range(-10, 10)) = -2.761199
        _ScrollY_Noise ("ScrollY_Noise", Range(-10, 10)) = 0
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _Distortion ("Distortion", Range(0, 1)) = 0
        _ScrollX_Normal ("ScrollX_Normal", Range(-10, 10)) = -2.761199
        _ScrollY_Normal ("ScrollY_Normal", Range(-10, 10)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles metal
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _TintColor;
            uniform float _ScrollX;
            uniform float _ScrollY;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform float _Intensity;
            uniform sampler2D _Noise; uniform float4 _Noise_ST;
            uniform float _NoisePower;
            uniform float _NoiseAmount;
            uniform float _ScrollX_Noise;
            uniform float _ScrollY_Noise;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform float _Distortion;
            uniform float _ScrollX_Normal;
            uniform float _ScrollY_Normal;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 node_5471 = _Time;
                float2 node_9061 = (i.uv0+float2((node_5471.g*_ScrollX_Normal),(node_5471.g*_ScrollY_Normal)));
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(node_9061, _NormalMap)));
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (float2(_NormalMap_var.r,_NormalMap_var.g)*_Distortion);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
////// Lighting:
////// Emissive:
                float4 node_1928 = _Time;
                float2 node_3108 = (i.uv0+float2((node_1928.g*_ScrollX_Noise),(node_1928.g*_ScrollY_Noise)));
                float4 _Noise_var = tex2D(_Noise,TRANSFORM_TEX(node_3108, _Noise));
                float node_7237 = pow(_Noise_var.r,_NoisePower);
                float4 node_1770 = _Time;
                float2 node_3651 = (lerp(i.uv0,float2(node_7237,node_7237),_NoiseAmount)+float2((node_1770.g*_ScrollX),(node_1770.g*_ScrollY)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_3651, _MainTex));
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                float3 node_2393 = ((_Intensity*_MainTex_var.rgb*_TintColor.rgb*i.vertexColor.rgb)*_Mask_var.rgb);
                float3 emissive = node_2393;
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,saturate(node_2393).r),1);
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0.5,0.5,0.5,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
