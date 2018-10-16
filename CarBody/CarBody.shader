﻿Shader "Unlit/CarBody"
{
	Properties
	{
		_AuxTex1 ("_AuxTex1", 2D) = "white" {}
		_MainTex ("_MainTex", 2D) = "white" {}
		_DiffAmbientMap ("_DiffAmbientMap", CUBE) = "sky" {}
		_SpecAmbientMap ("_SpecAmbientMap", CUBE) = "sky" {}
		_gkAliasDimming ("_gkAliasDimming", FLOAT) = 1
		_kMetallicCoverage ("_kMetallicCoverage", FLOAT) = 1
		_kClearCoatF0 ("_kClearCoatF0", FLOAT) = 1
		_kClearCoatShininess ("_kClearCoatShininess", FLOAT) = 1
		_kFresnelPower ("_kFresnelPower", FLOAT) = 1
		_kMetallicBoost ("_kMetallicBoost", FLOAT) = 1
		_kLiveryUVScale ("_kLiveryUVScale", FLOAT) = 1
		_kMetallicShininess ("_kMetallicShininess", FLOAT) = 1

		_gkVehicleExposure ("_gkVehicleExposure", vector) = (1,1,1,1)
		_kDiffuseTint ("_kDiffuseTint", Color) = (1,1,1,1)
		_kMetallicTint ("_kMetallicTint", Color) = (1,1,1,1)


	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			#include  "../CGIncludes/RolantinCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal:NORMAL;
				float4 color:COLOR;
			};

			struct v2f
			{
				float3 vs_TEXCOORD0 : TEXCOORD0; //view
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float2 vs_TEXCOORD3:TEXCOORD3; //uv
				float3 vs_TEXCOORD1:TEXCOORD1; //normal
				float4 vs_TEXCOORD2:TEXCOORD2; //color
			};

			uniform float2 _gkVehicleExposure;
			uniform float _gkAliasDimming;
			uniform float _kMetallicCoverage;
			uniform float _kMetallicShininess;
			uniform float _kClearCoatF0;
			uniform float _kClearCoatShininess;
			uniform  float3 _kDiffuseTint;
			uniform float3 _kMetallicTint;
			uniform float _kFresnelPower;
			uniform float _kMetallicBoost;
			uniform sampler2D _AuxTex1;
			uniform sampler2D _MainTex;
			uniform samplerCUBE _DiffAmbientMap;
			uniform samplerCUBE _SpecAmbientMap;
			uniform float _kLiveryUVScale;
			
			v2f vert (appdata v)
			{
				v2f o;
				float realview;
				int u_xlati0;
				float4 u_xlat1;
				float4 finalr;
				float3 u_xlat3;

				o.vertex = UnityObjectToClipPos(v.vertex);
			
				UNITY_TRANSFER_FOG(o,o.vertex);
				
				o.vs_TEXCOORD0 = _WorldSpaceCameraPos - o.vertex; ///view
				o.vs_TEXCOORD1 = UnityObjectToWorldNormal(v.normal); //normal
				o.vs_TEXCOORD2 = v.color ;
				o.vs_TEXCOORD3 = v.uv * _kLiveryUVScale;   //uv

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 viewDir = i.vs_TEXCOORD0;
				float3 NomalDir = i.vs_TEXCOORD1;
				float2 VertexColor = i.vs_TEXCOORD2;
				float2 uv = i.vs_TEXCOORD3;

				
		
				float u_xlat10_1;
				float3 finalr;
				float4 u_xlat10_2;
				float3 u_xlat3;
				float3 u_xlat4;
				float4 u_xlat10_4;
				float4 u_xlat10_5;
				float3 u_xlat6;
				float3 u_xlat16_7;
				float3 u_xlat10_7;
				float u_xlat8;
				float u_xlat16_8;
				float3 u_xlat10;
				float u_xlat16_10;
				float2 u_xlat13;
				float2 u_xlat15;
				float2 u_xlat16_15;
				float u_xlat17;
				float _normal;
				float finalr2;
				float u_xlat16_22;
				float finalr3;

				float3 realview;
						float4 realnormal;

				realview.x = dot(viewDir, viewDir);
				realview.x = rsqrt(realview.x);

				realview.xyz = realview.x * viewDir;





				_normal = dot(NomalDir, NomalDir);

				_normal = rsqrt(_normal);

				realnormal.xyz = float3(_normal.xxx) * NomalDir;






				_normal = dot((-realview.xyz), realnormal.xyz);

				_normal = _normal + _normal;



				finalr.xyz = realnormal.xyz *(-float3(_normal.xxx)) + (-realview.xyz);



				realview.x = dot(realnormal.xyz, realview.xyz);

				#ifdef UNITY_ADRENO_ES3
				realview.x = min(max(realview.x, 0.0), 1.0);
				#else
				realview.x = clamp(realview.x, 0.0, 1.0);
				#endif
				u_xlat10_7.xyz = texCUBE(_DiffAmbientMap, realnormal.xyz).xyz;
				u_xlat10_1 = texCUBE(_DiffAmbientMap, finalr.xyz).w;
				u_xlat16_8 = u_xlat10_1 * 15.9375;
				realnormal.x = (-u_xlat10_1)  * _gkAliasDimming + 1.0;
				u_xlat3.xyz = float3((-float(_kClearCoatF0)) + float(1.0), (-float(_kClearCoatShininess)) + float(1.0), (-float(_kMetallicShininess)) + float(1.0));
				u_xlat15.xy = float2(u_xlat3.y * float(6.0), u_xlat3.z * float(6.0));
				u_xlat15.xy = max(float2(u_xlat16_8,u_xlat16_8), u_xlat15.xy);

				u_xlat10_4 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat15.y));
				u_xlat10_5 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat15.x));

				u_xlat15.x = log2(realview.x);
				u_xlat15.x = u_xlat15.x * _kFresnelPower;
				u_xlat15.x = exp2(u_xlat15.x);
				finalr2 = u_xlat15.x * _kMetallicCoverage + -0.25;
				#ifdef UNITY_ADRENO_ES3
				finalr2 = min(max(finalr2, 0.0), 1.0);
				#else
				finalr2 = clamp(finalr2, 0.0, 1.0);
				#endif
				finalr3 = (-finalr2) * 1.33333302 + 1.0;
				finalr2 = finalr2 * 1.33333302;
				finalr3 = u_xlat10_4.w * finalr3;
				u_xlat16_10 = dot(float3(0.298999995, 0.587000012, 0.114), u_xlat10_4.xyz);
				finalr2 = finalr3  *6.0 + finalr2;
				finalr2 = finalr2 + -0.25;
				finalr3 = (-finalr2) + 1.0;
				u_xlat17 = u_xlat15.x * _kMetallicCoverage;
				finalr2 = u_xlat17 * finalr3 + finalr2;
				finalr2 = max(finalr2, 0.0);
				finalr3 = dot(float3(0.298999995, 0.587000012, 0.114), _kMetallicTint.xyz);
				u_xlat4.x = u_xlat16_10 * finalr3;
				finalr3 = min(u_xlat15.x, u_xlat16_10);
				u_xlat13.x = dot(float3(-0.147, -0.289000005, 0.43599999), _kMetallicTint.xyz);
				u_xlat13.y = dot(float3(0.61500001, -0.514999986, -0.100000001), _kMetallicTint.xyz);
				u_xlat4.yz = float2(finalr3,finalr3) * u_xlat13.xy;
				u_xlat6.x = dot(float2(1.0, 1.13999999), u_xlat4.xz);
				u_xlat6.y = dot(float3(1.0, -0.395000011, -0.58099997), u_xlat4.xyz);
				u_xlat6.z = dot(float2(1.0, 2.03200006), u_xlat4.xy);
				u_xlat4.xyz = float3(finalr2,finalr2 ,finalr2) * u_xlat6.xyz;
				u_xlat4.xyz = u_xlat4.xyz * float3(_kMetallicBoost,_kMetallicBoost,_kMetallicBoost);
				u_xlat10.xyz = u_xlat17* u_xlat4.xyz;
				finalr2 = u_xlat15.x * -5.55472994 + -6.98316002;
				u_xlat15.x = u_xlat15.x * finalr2;
				u_xlat15.x = exp2(u_xlat15.x);
				u_xlat15.x = u_xlat15.x  *u_xlat3.x;
				finalr2 = (-_kClearCoatShininess) * 3.0 + 4.0;
				u_xlat15.x = u_xlat15.x * finalr2;
				u_xlat15.x = u_xlat15.x + _kClearCoatF0;
				finalr2 = u_xlat15.x + -0.25;
				#ifdef UNITY_ADRENO_ES3
				finalr2 = min(max(finalr2, 0.0), 1.0);
				#else
				finalr2 = clamp(finalr2, 0.0, 1.0);
				#endif
				finalr3 = (-finalr2) * 1.33333302 + 1.0;
				finalr2 = finalr2 * 1.33333302;
				finalr3 = u_xlat10_5.w * finalr3;
				finalr2 = finalr3 * 6.0 + finalr2;
				finalr2 = finalr2 + -0.25;
				finalr3 = (-finalr2) + 1.0;
				finalr2 = u_xlat15.x * finalr3 + finalr2;
				finalr2 = max(finalr2, 0.0);
				u_xlat4.xyz = finalr2 * u_xlat10_5.xyz;
				u_xlat3.xyz = u_xlat4.xyz * u_xlat15.xxx + u_xlat10.xyz;
				u_xlat15.x = (-u_xlat15.x) + 1.0;
				u_xlat3.xyz = realnormal.xxx * u_xlat3.xyz;
				u_xlat4.xyz = u_xlat10_7.xyz * _kDiffuseTint.xyz;
				u_xlat3.xyz = u_xlat4.xyz * u_xlat15.xxx + u_xlat3.xyz;
				u_xlat10_4.xyz = tex2D(_AuxTex1, uv).xyz;
				u_xlat16_15.xy = (-u_xlat10_4.xy) + float2(1.0, 1.0);
				u_xlat16_22 = u_xlat16_15.y * 6.0;
				u_xlat8 = max(u_xlat16_8, u_xlat16_22);
				u_xlat10_2 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat8) );
				u_xlat8 = realview.x * -5.55472994 + -6.98316002;
				realview.x = realview.x * u_xlat8;
				realview.x = exp2(realview.x);
				realview.x = realview.x * u_xlat16_15.x;
				u_xlat16_8 = (-u_xlat10_4.y) * 3.0 + 4.0;
				realview.x = realview.x * u_xlat16_8;
				realview.x = realview.x + u_xlat10_4.x;
				u_xlat8 = u_xlat10_4.z * VertexColor.y;
				u_xlat15.x = realview.x + -0.25;
				#ifdef UNITY_ADRENO_ES3
				u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
				#else
				u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
				#endif
				finalr2 = (-u_xlat15.x)*  1.33333302 + 1.0;
				u_xlat15.x = u_xlat15.x * 1.33333302;
				finalr2 = u_xlat10_2.w * finalr2;
				u_xlat15.x = finalr2 * 6.0 + u_xlat15.x;
				u_xlat15.x = u_xlat15.x + -0.25;
				finalr2 = (-u_xlat15.x) + 1.0;
				u_xlat15.x = realview.x * finalr2 + u_xlat15.x;
				u_xlat15.x = max(u_xlat15.x, 0.0);
				finalr.xyz = u_xlat15.xxx * u_xlat10_2.xyz;
				finalr.xyz = realview.xxx * finalr.xyz;
				realview.x = (-realview.x) + 1.0;
				realnormal.xzw = realnormal.xxx*  finalr.xyz;
				u_xlat10_2.xyz = tex2D(_MainTex, uv).xyz;
				u_xlat16_7.xyz = u_xlat10_7.xyz * u_xlat10_2.xyz;
				realview.xyz = u_xlat16_7.xyz * realview.xxx + realnormal.xzw;
				realview.xyz = (-u_xlat3.xyz) + realview.xyz;
				realview.xyz = u_xlat8 * realview.xyz + u_xlat3.xyz;
				float3 light = DirectionalLight(i.vs_TEXCOORD1)[0];
				float4 SV_Target0;
				_normal = VertexColor.x * _gkVehicleExposure.xxxy.z;
				SV_Target0.xyz = _normal * realview.xyz ;
				SV_Target0.w = 1.0;

			

				return float4(SV_Target0.xyz,SV_Target0.w);
			}
			ENDCG
		}
	}
}