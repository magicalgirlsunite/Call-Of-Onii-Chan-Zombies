// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DotTiling"
{
	Properties
	{
		_Texture("Texture", 2D) = "white" {}
		[HDR]_ColorTint("ColorTint", Color) = (1,1,1,0)
		_Mask("Mask", 2D) = "white" {}
		_MaskScale("MaskScale", Float) = 1
		_Texture2("Texture2", 2D) = "white" {}
		_BackGroundIntencity("BackGroundIntencity", Float) = 1
		[Toggle]_UseCircleGradation("UseCircleGradation", Float) = 0
		_CircleGradation("CircleGradation", 2D) = "white" {}
		_CircleIntencity("CircleIntencity", Float) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture;
		uniform float4 _Texture_ST;
		uniform float4 _ColorTint;
		uniform sampler2D _Texture2;
		uniform float4 _Texture2_ST;
		uniform float4 _Color0;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float _MaskScale;
		uniform float _UseCircleGradation;
		uniform float _BackGroundIntencity;
		uniform sampler2D _CircleGradation;
		uniform float4 _CircleGradation_ST;
		uniform float _CircleIntencity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture = i.uv_texcoord * _Texture_ST.xy + _Texture_ST.zw;
			float4 tex2DNode1 = tex2D( _Texture, uv_Texture );
			float2 uv_Texture2 = i.uv_texcoord * _Texture2_ST.xy + _Texture2_ST.zw;
			float4 tex2DNode49 = tex2D( _Texture2, uv_Texture2 );
			float4 blendOpSrc79 = tex2DNode49;
			float4 blendOpDest79 = _Color0;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode9 = tex2D( _Mask, ( ( uv_Mask * _MaskScale ) + ( ( 1.0 - _MaskScale ) * 0.5 ) ) );
			float4 lerpResult69 = lerp( ( tex2DNode1 * _ColorTint ) , ( saturate( ( blendOpSrc79 + blendOpDest79 - 1.0 ) )) , tex2DNode9);
			o.Emission = lerpResult69.rgb;
			float lerpResult8 = lerp( tex2DNode1.b , 0.5 , tex2DNode9.r);
			float4 temp_cast_2 = (lerpResult8).xxxx;
			float4 temp_cast_3 = (tex2DNode1.a).xxxx;
			float2 uv_CircleGradation = i.uv_texcoord * _CircleGradation_ST.xy + _CircleGradation_ST.zw;
			float4 lerpResult68 = lerp( temp_cast_3 , ( tex2DNode49 * _BackGroundIntencity ) , step( tex2D( _CircleGradation, uv_CircleGradation ).r , _CircleIntencity ));
			o.Alpha = saturate( (( _UseCircleGradation )?( lerpResult68 ):( temp_cast_2 )) ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
2391;176;1920;1006;2705.397;254.7775;1.275788;True;False
Node;AmplifyShaderEditor.CommentaryNode;59;-2748.799,1042.372;Inherit;False;1077.058;368.4355;CenterMask;7;22;24;14;21;25;23;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2593.861,1290.808;Inherit;False;Property;_MaskScale;MaskScale;3;0;Create;True;0;0;0;False;0;False;1;-12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2698.799,1114.981;Inherit;False;0;9;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.25,-0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;24;-2380.86,1282.808;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-2201.86,1277.808;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2405.86,1106.808;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-2145.86,1109.808;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;62;-1462.833,1192.204;Inherit;True;Property;_CircleGradation;CircleGradation;7;0;Create;True;0;0;0;False;0;False;-1;None;217dd8b8713cf8044baa2a4b3fbf01e2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-1440.426,646.2311;Inherit;False;Property;_BackGroundIntencity;BackGroundIntencity;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1323.275,1459.191;Inherit;False;Property;_CircleIntencity;CircleIntencity;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;49;-2257.399,446.8627;Inherit;True;Property;_Texture2;Texture2;4;0;Create;True;0;0;0;False;0;False;-1;None;111fbfe6397b6c14b942daf3df8e5fc3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-2042.045,-316.4939;Inherit;True;Property;_Texture;Texture;0;0;Create;True;0;0;0;False;0;False;-1;None;111fbfe6397b6c14b942daf3df8e5fc3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;67;-1081.038,1199.91;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-954.8352,376.5531;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;9;-1992.74,1092.372;Inherit;True;Property;_Mask;Mask;2;0;Create;True;0;0;0;False;0;False;-1;8a9dd60f92ccb114586eac7b5a0d5e7c;8a9dd60f92ccb114586eac7b5a0d5e7c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-451.7942,-270.4005;Inherit;False;Property;_ColorTint;ColorTint;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;4,4,4,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;68;223.6921,585.1744;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;8;172.7405,174.8106;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;80;-1961.613,185.3693;Inherit;False;Property;_Color0;Color 0;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.02878418,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;60;716.238,270.689;Inherit;False;Property;_UseCircleGradation;UseCircleGradation;6;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-157.5982,-368.4158;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;79;-1624.372,228.8233;Inherit;False;LinearBurn;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;69;253.2621,-209.1544;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;66;1090.612,249.9153;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;4;1617.057,-35.04691;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;DotTiling;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;22;0
WireConnection;25;0;24;0
WireConnection;21;0;14;0
WireConnection;21;1;22;0
WireConnection;23;0;21;0
WireConnection;23;1;25;0
WireConnection;67;0;62;1
WireConnection;67;1;64;0
WireConnection;57;0;49;0
WireConnection;57;1;58;0
WireConnection;9;1;23;0
WireConnection;68;0;1;4
WireConnection;68;1;57;0
WireConnection;68;2;67;0
WireConnection;8;0;1;3
WireConnection;8;2;9;0
WireConnection;60;0;8;0
WireConnection;60;1;68;0
WireConnection;7;0;1;0
WireConnection;7;1;6;0
WireConnection;79;0;49;0
WireConnection;79;1;80;0
WireConnection;69;0;7;0
WireConnection;69;1;79;0
WireConnection;69;2;9;0
WireConnection;66;0;60;0
WireConnection;4;2;69;0
WireConnection;4;9;66;0
ASEEND*/
//CHKSM=5FD18F524DF3D7C5D6B5042A3A8237394303CADD