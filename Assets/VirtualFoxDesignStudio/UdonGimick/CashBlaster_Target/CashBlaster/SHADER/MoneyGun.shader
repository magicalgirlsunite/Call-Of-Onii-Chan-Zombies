// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MoneyGun"
{
	Properties
	{
		_Slide_Color("Slide_Color", Color) = (0,0,0,0)
		_EnergyBox_Color("EnergyBox_Color", Color) = (0,0,0,0)
		_EmissionColor("EmissionColor", Color) = (0,0,0,0)
		_EmissionIntencity("EmissionIntencity", Float) = 0
		_Scroll("Scroll", Float) = 0
		_EmissionScroll("EmissionScroll", 2D) = "white" {}
		_AlbedoTransparency("AlbedoTransparency", 2D) = "white" {}
		_MOS("MOS", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_NormalIntencity("NormalIntencity", Float) = 0
		_ColorMask1("ColorMask1", 2D) = "white" {}
		_ColorMask2("ColorMask2", 2D) = "white" {}
		_EmissionMask("EmissionMask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float _NormalIntencity;
		uniform float4 _Slide_Color;
		uniform sampler2D _ColorMask1;
		uniform float4 _ColorMask1_ST;
		uniform float4 _EnergyBox_Color;
		uniform sampler2D _ColorMask2;
		uniform float4 _ColorMask2_ST;
		uniform sampler2D _AlbedoTransparency;
		uniform sampler2D _EmissionMask;
		uniform float4 _EmissionMask_ST;
		uniform sampler2D _EmissionScroll;
		uniform float4 _EmissionScroll_ST;
		uniform float _Scroll;
		uniform float4 _EmissionColor;
		uniform float _EmissionIntencity;
		uniform sampler2D _MOS;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = UnpackScaleNormal( tex2D( _Normal, i.uv_texcoord ), _NormalIntencity );
			float2 uv_ColorMask1 = i.uv_texcoord * _ColorMask1_ST.xy + _ColorMask1_ST.zw;
			float4 tex2DNode8 = tex2D( _ColorMask1, uv_ColorMask1 );
			float4 lerpResult9 = lerp( float4( 0,0,0,0 ) , _Slide_Color , tex2DNode8.r);
			float2 uv_ColorMask2 = i.uv_texcoord * _ColorMask2_ST.xy + _ColorMask2_ST.zw;
			float4 tex2DNode17 = tex2D( _ColorMask2, uv_ColorMask2 );
			float4 lerpResult19 = lerp( float4( 0,0,0,0 ) , _EnergyBox_Color , tex2DNode17.r);
			float4 tex2DNode3 = tex2D( _AlbedoTransparency, i.uv_texcoord );
			o.Albedo = ( ( lerpResult9 + lerpResult19 + ( ( 1.0 - tex2DNode8.r ) * ( 1.0 - tex2DNode17.r ) ) ) * tex2DNode3 ).rgb;
			float2 uv_EmissionMask = i.uv_texcoord * _EmissionMask_ST.xy + _EmissionMask_ST.zw;
			float4 tex2DNode32 = tex2D( _EmissionMask, uv_EmissionMask );
			float2 uv_EmissionScroll = i.uv_texcoord * _EmissionScroll_ST.xy + _EmissionScroll_ST.zw;
			float2 appendResult54 = (float2(uv_EmissionScroll.x , ( uv_EmissionScroll.y + _Scroll )));
			o.Emission = ( ( ( tex2DNode32 * tex2D( _EmissionScroll, appendResult54 ) ) * ( _EmissionColor * _EmissionIntencity ) ) * tex2DNode3 ).rgb;
			float4 tex2DNode4 = tex2D( _MOS, i.uv_texcoord );
			o.Metallic = tex2DNode4.r;
			o.Smoothness = tex2DNode4.a;
			o.Occlusion = tex2DNode4.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
2622;121;1920;1018;2874.616;1029.191;3.121961;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-972.1799,730.4106;Inherit;False;0;37;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;53;-826.5254,985.3352;Inherit;False;Property;_Scroll;Scroll;4;0;Create;True;0;0;0;False;0;False;0;-0.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-562.7794,903.9792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;29;-1263.855,-677.6185;Inherit;False;755.4864;499.6994;Charger;3;17;18;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;28;-890.0377,-1263.342;Inherit;False;887.8799;486.0224;Slide;3;10;8;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;54;-387.6383,726.3173;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;30;-446.0522,-759.8284;Inherit;False;413.2627;296.7991;Others;3;26;25;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;17;-1204.797,-607.2375;Inherit;True;Property;_ColorMask2;ColorMask2;13;0;Create;True;0;0;0;False;0;False;-1;9fa6dcd97ace9924d896d9c33255f739;9fa6dcd97ace9924d896d9c33255f739;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-1034.721,110.7687;Inherit;True;Property;_EmissionMask;EmissionMask;14;0;Create;True;0;0;0;False;0;False;-1;509a0615ac5850f4f80fcfd246995806;509a0615ac5850f4f80fcfd246995806;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-840.0377,-1007.319;Inherit;True;Property;_ColorMask1;ColorMask1;12;0;Create;True;0;0;0;False;0;False;-1;5ef5e172c6056a94c9e98358bf610cdb;5ef5e172c6056a94c9e98358bf610cdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;12.90892,668.8601;Inherit;True;Property;_EmissionScroll;EmissionScroll;7;0;Create;True;0;0;0;False;0;False;-1;None;5b66d32fc31b914468ea132cb2810cbc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;42;132.5955,955.0887;Inherit;False;Property;_EmissionIntencity;EmissionIntencity;3;0;Create;True;0;0;0;False;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;48;-51.0573,459.1912;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;26;-396.0522,-573.0294;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-1132.96,-384.9191;Inherit;False;Property;_EnergyBox_Color;EnergyBox_Color;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;39;454.0152,1088.021;Inherit;False;Property;_EmissionColor;EmissionColor;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;25;-389.354,-709.8284;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-800.1422,-1213.342;Inherit;False;Property;_Slide_Color;Slide_Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;623.3096,749.8458;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;19;-692.3681,-458.028;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;734.8564,932.4547;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;9;-186.1579,-1020.177;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-201.7896,-648.1689;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-70.80452,-1.685349;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;795.4565,762.9551;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;253.4938,-145.6587;Inherit;True;Property;_AlbedoTransparency;AlbedoTransparency;8;0;Create;True;0;0;0;False;0;False;-1;4287dd924b0c750418b61e090f3d1d8e;4287dd924b0c750418b61e090f3d1d8e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;21;200.2051,-661.5868;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-59.75101,305.6468;Inherit;False;Property;_NormalIntencity;NormalIntencity;11;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;56;-89.56461,1030.828;Inherit;False;Property;_Use_AutoScroll;Use_AutoScroll;5;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;-685.4453,-75.66014;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;55;-219.2274,927.4001;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;242.5897,312.2533;Inherit;True;Property;_Normal;Normal;10;1;[Normal];Create;True;0;0;0;False;0;False;-1;None;518e365360bc3ee4f8d23aedb392d723;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;950.8381,660.3102;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-782.9521,1110.91;Inherit;False;Property;_ScrollSpeed;ScrollSpeed;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;882.2562,-162.7458;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;49;-1012.468,-99.11613;Inherit;False;Property;_Color3;Color3;15;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;243.3092,95.25224;Inherit;True;Property;_MOS;MOS;9;0;Create;True;0;0;0;False;0;False;-1;None;ea4096e7626a3ed4d904bfc02def56b8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;60;-489.8862,1035.089;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1752.98,-168.8505;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;MoneyGun;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;51;0;34;2
WireConnection;51;1;53;0
WireConnection;54;0;34;1
WireConnection;54;1;51;0
WireConnection;37;1;54;0
WireConnection;48;0;32;0
WireConnection;26;0;17;1
WireConnection;25;0;8;1
WireConnection;38;0;48;0
WireConnection;38;1;37;0
WireConnection;19;1;18;0
WireConnection;19;2;17;1
WireConnection;43;0;39;0
WireConnection;43;1;42;0
WireConnection;9;1;10;0
WireConnection;9;2;8;1
WireConnection;27;0;25;0
WireConnection;27;1;26;0
WireConnection;40;0;38;0
WireConnection;40;1;43;0
WireConnection;3;1;6;0
WireConnection;21;0;9;0
WireConnection;21;1;19;0
WireConnection;21;2;27;0
WireConnection;47;1;49;0
WireConnection;47;2;32;0
WireConnection;55;2;60;0
WireConnection;5;1;6;0
WireConnection;5;5;50;0
WireConnection;45;0;40;0
WireConnection;45;1;3;0
WireConnection;31;0;21;0
WireConnection;31;1;3;0
WireConnection;4;1;6;0
WireConnection;60;1;58;0
WireConnection;0;0;31;0
WireConnection;0;1;5;0
WireConnection;0;2;45;0
WireConnection;0;3;4;1
WireConnection;0;4;4;4
WireConnection;0;5;4;2
ASEEND*/
//CHKSM=DDF691C0BFB8A6FAD61068612638E60704ABBBC9