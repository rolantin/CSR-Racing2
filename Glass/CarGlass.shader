Shader "Unlit/CarGlass"
{
	Properties
	{
		_AuxTex1 ("_AuxTex1", 2D) = "white" {}
		_AuxTex2 ("_AuxTex2", 2D) = "white" {}
		_gkAliasDimming ("_gkAliasDimming", FLOAT) = 0
		_kf0 ("_kf0", FLOAT) = 0
		_kShininess ("_kShininess", FLOAT) = 0
		_gkVehicleExposure ("_gkVehicleExposure", vector) = (1,1,1,1)


		_DiffAmbientMap("_DiffAmbientMap",CUBE) = "sky"
		_SpecAmbientMap("_SpecAmbientMap",CUBE) = "sky"
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		LOD 100
		//Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		//ColorMask RGB


		Pass
		{   

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			uniform float2 _gkVehicleExposure;
			uniform float _gkAliasDimming;
			uniform float _kf0;
			uniform float _kShininess;
			uniform sampler2D _AuxTex2;
			uniform sampler2D _AuxTex1;
			uniform samplerCUBE _DiffAmbientMap;
			uniform samplerCUBE _SpecAmbientMap;

			struct vertexin
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal:NORMAL;
				float4 color:COLOR;
			};

			struct vertexout
			{   
			    float4 pos:SV_POSITION;	//pos vertex must UnityObjectToClipPos( v.vertex );				
				float2 vs_TEXCOORD1:TEXCOORD0;
				float3 vs_TEXCOORD2:TEXCOORD2;
			
			   float3 vs_TEXCOORD0:TEXCOORD3;

				float4 posWorld:TEXCOORD1;

			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			vertexout vert (vertexin v)
			{
				vertexout o;

				o.posWorld = mul(unity_ObjectToWorld, v.vertex);

				o.vs_TEXCOORD0 =  (_WorldSpaceCameraPos.xyz - o.posWorld);

				//o.vs_TEXCOORD0 = UnityObjectToClipPos(v.vs_TEXCOORD0);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				float4 color = v.color.w * 255.0 + 0.100000001;

				 o.vs_TEXCOORD2 = UnityObjectToWorldNormal(v.normal);
			     o.vs_TEXCOORD1 =v.uv;

			     o.pos = UnityObjectToClipPos( v.vertex );			  				
				return o;
			}
			
			fixed4 frag (vertexout i) : SV_Target
			{
				float2 uv = i.vs_TEXCOORD1;
				float3 ViewDirection = i.vs_TEXCOORD0;
				float3 normaldir = i.vs_TEXCOORD2;

				
				
			
			
			
				
	
				float3 u_xlat4;
			
				float3 u_xlat6;
				float u_xlat8;
				
				
				 float u_xlat16_9;
				float u_xlat12;
				
				
				
				float3 u_xlat0 ;
			
				u_xlat0.x = dot(ViewDirection.xyz, ViewDirection.xyz);
				u_xlat0.x = rsqrt(u_xlat0.x);
			    u_xlat0.xyz = u_xlat0.x * ViewDirection.xyz;

///normal dir

			    float NorDir = dot(normaldir, normaldir);
			    NorDir = rsqrt(NorDir);
			    float3 u_xlat1 = NorDir.x* normaldir.xyz;
			    NorDir = dot(u_xlat1.xyz, u_xlat0.xyz);


			#ifdef UNITY_ADRENO_ES3
			    NorDir = min(max(NorDir, 0.0), 1.0);
			#else
			    NorDir = clamp(NorDir, 0.0, 1.0);
			#endif

			   float u_xlat19 = NorDir * -5.55472994 + -6.98316002;

			    NorDir = NorDir * u_xlat19;
			    NorDir = exp2(NorDir);


			   float3 _AuxTex2_var = tex2D(_AuxTex2, uv).xyz;
			   float3  AuxTex2_V = (1-_AuxTex2_var);

			    u_xlat19 = NorDir * AuxTex2_V.x;			
			    u_xlat19 = u_xlat19 / ((-_AuxTex2_var.y) * 3.0 + 4.0);
			    u_xlat19 = u_xlat19 + _AuxTex2_var.x;
			   float u_xlat2 = u_xlat19 + -0.25;



			#ifdef UNITY_ADRENO_ES3
			    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
			#else
			    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
			#endif
			    u_xlat8 = (-u_xlat2) * 1.33333302 + 1.0;
			    u_xlat2 = u_xlat2 * 1.33333302;
			  float  u_xlat20 = dot((-u_xlat0.xyz), u_xlat1.xyz);
			    u_xlat20 = u_xlat20 + u_xlat20;


			    u_xlat0.xyz = u_xlat1.xyz * (-float3(u_xlat20.xxx)) + (-u_xlat0.xyz);

		

			    float4 IBL = texCUBE(_DiffAmbientMap, normaldir);
			    float IBL2 = texCUBE(_DiffAmbientMap, u_xlat0.xyz).w;

			    AuxTex2_V.x = IBL2 * 15.9375;
			    u_xlat20 = (-IBL2) * _gkAliasDimming + 1.0;
			    u_xlat16_9 = AuxTex2_V.y * 6.0;
			    float SPLBias = max(AuxTex2_V.x, u_xlat16_9);
			   // float4 SPL = texCUBElod(_SpecAmbientMap,float4(u_xlat0.xyz, SPLBias) );
			     float4 SPL = texCUBElod(_SpecAmbientMap,float4(u_xlat0.xyz, 0) );
			

			    u_xlat8 = u_xlat8 * SPL.w;
			    u_xlat2 = u_xlat8 * 6.0 + u_xlat2;
			    u_xlat2 = u_xlat2 + -0.25;
			    u_xlat8 = (-u_xlat2) + 1.0;
			    u_xlat2 = u_xlat19 * u_xlat8 + u_xlat2;
			    u_xlat2 = max(u_xlat2, 0.0);
			    u_xlat4.xyz = float3(u_xlat2.xxx) * SPL.xyz;
			    u_xlat4.xyz = float3(u_xlat19.xxx) * u_xlat4.xyz;
			    u_xlat19 = (-u_xlat19.x) + 1.0;
			    u_xlat4.xyz = float3(u_xlat20.xxx) * u_xlat4.xyz;
			    float3 AuxMap = tex2D(_AuxTex1, uv).xyz;
			    float3 IBLMask = IBL * AuxMap;
			    u_xlat1.xyz = IBLMask * float3(u_xlat19.xxx) + u_xlat4.xyz;
			    u_xlat1.xyz = _AuxTex2_var.zzz * u_xlat1.xyz;

			    u_xlat19 = (-_kShininess) + 1.0;
			    u_xlat19 = u_xlat19 * 6.0;
			    u_xlat19 = max(AuxTex2_V.x, u_xlat19);

			    SPL = texCUBElod(_SpecAmbientMap, float4 (u_xlat0.xyz, 0));
			       
			    u_xlat0.x = (-_kf0) + 1.0;
			    u_xlat0.x = u_xlat0.x * NorDir + _kf0;
			    u_xlat6.x = u_xlat0.x + -0.25;


			#ifdef UNITY_ADRENO_ES3
			    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
			#else
			    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
			#endif
			    u_xlat12 = (-u_xlat6.x) * 1.33333302 + 1.0;
			    u_xlat6.x = u_xlat6.x * 1.33333302;
			    u_xlat12 = SPL.w * u_xlat12;
			    u_xlat6.x = u_xlat12 * 6.0 + u_xlat6.x;
			    u_xlat6.x = u_xlat6.x + -0.25;
			    u_xlat12 = (-u_xlat6.x) + 1.0;
			    u_xlat6.x = u_xlat0.x * u_xlat12 + u_xlat6.x;
			    u_xlat0.x = u_xlat0.x * AuxTex2_V.z;
			    u_xlat6.x = max(u_xlat6.x, 0.0);
			    u_xlat6.xyz = u_xlat6.xxx * SPL.xyz;
			    u_xlat19 = u_xlat20 * u_xlat0.x;

			    float4 SV_Target0;

			    SV_Target0.w = u_xlat0.x * u_xlat20 + _AuxTex2_var.z;

			    u_xlat0.xyz = u_xlat6.xyz * float3(u_xlat19.xxx) + u_xlat1.xyz;
			    SV_Target0.xyz = u_xlat0.xyz * float3(_gkVehicleExposure.x, _gkVehicleExposure.x, _gkVehicleExposure.x);
			   
				return float4 (SV_Target0.xyz,SV_Target0.w);
			}
			ENDCG
		}
	}
}
