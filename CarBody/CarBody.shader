Shader "Unlit/CarBody"
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

		_gkVehicleExposure ("_gkVehicleExposure", FLOAT) = 1
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

			uniform float _gkVehicleExposure;
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
				float viewdir;
				int u_xlati0;
				float4 u_xlat1;
				float4 finalr;
				float3 u_xlat3;

				o.vertex = UnityObjectToClipPos(v.vertex);

				float3 PosWorld = mul(unity_ObjectToWorld,v.vertex);
			
				UNITY_TRANSFER_FOG(o,o.vertex);
				
				o.vs_TEXCOORD0 = _WorldSpaceCameraPos - PosWorld; ///view
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

				float3 u_xlat0;
			
				float IBLw;
				float3 u_xlat2;
		
				float3 u_xlat3;
				float3 DiffuseIBLColor;
				float4 u_xlat10_4;
				float4 u_xlat10_5;
				float3 u_xlat6;
			
				float3 IBL;
				float u_xlat8;
				float u_xlat16_8;
				float3 u_xlat10;
				float u_xlat16_10;
				float2 u_xlat13;
				float2 u_xlat15;
				float2 u_xlat16_15;
				float u_xlat17;
				
				float kMetallicCoverage;
				float u_xlat16_22;
				float u_xlat23;

				
		
	//u_xlat0.x = dot(viewDir.xyz, viewDir.xyz);
   // u_xlat0.x = rsqrt(u_xlat0.x);
  //  u_xlat0.xyz = u_xlat0.xxx * viewDir.xyz;

    float3 viewdirx = normalize(viewDir);


 //normalize normal   

   //float normalx = dot(NomalDir.xyz, NomalDir.xyz);

   // normalx = rsqrt(normalx);
  //  float4 u_xlat1;
  //  u_xlat1.xyz = (normalx) * NomalDir.xyz;

   float3 normalx = normalize(NomalDir.xyz);

   float vdn = dot((-viewdirx), normalx);
   float n2 = vdn + vdn;
    u_xlat2.xyz = normalx.xyz * (-(n2)) + (-viewdirx.xyz);


    u_xlat0.x = dot(normalx, viewdirx);

#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    IBL.xyz = texCUBE(_DiffAmbientMap, normalx).xyz;



    IBLw = texCUBE(_DiffAmbientMap, u_xlat2.xyz).w;
    
    u_xlat16_8 = IBLw * 15.9375;

    u_xlat1.x = (-IBLw) * _gkAliasDimming + 1.0;

    u_xlat3.xyz = float3((-float(_kClearCoatF0)) + float(1.0), (-float(_kClearCoatShininess)) + float(1.0), (-float(_kMetallicShininess)) + float(1.0));
    u_xlat15.xy = float2(u_xlat3.y * float(6.0), u_xlat3.z * float(6.0));
    u_xlat15.xy = max((u_xlat16_8), u_xlat15.xy);

    u_xlat10_4 = texCUBElod(_SpecAmbientMap,float4 (u_xlat2.xyz, u_xlat15.y) );
    u_xlat10_5 = texCUBElod(_SpecAmbientMap,float4(u_xlat2.xyz, u_xlat15.x)) ;

    u_xlat15.x = log2(u_xlat0.x);
    u_xlat15.x = u_xlat15.x * _kFresnelPower;
    u_xlat15.x = exp2(u_xlat15.x);

    kMetallicCoverage = (u_xlat15.x * _kMetallicCoverage + -0.25) * 1.33333302;




    u_xlat23 = (-kMetallicCoverage) * 1.33333302 + 1.0;
 



    u_xlat23 = u_xlat10_4.w * u_xlat23;
    u_xlat16_10 = dot(float3(0.298999995, 0.587000012, 0.114), u_xlat10_4.xyz);
 
    u_xlat17 = u_xlat15.x * _kMetallicCoverage;
    kMetallicCoverage = u_xlat17 * u_xlat23 + kMetallicCoverage;
   
    u_xlat23 = dot(float3(0.298999995, 0.587000012, 0.114), _kMetallicTint.xyz);
    DiffuseIBLColor.x = u_xlat16_10 * u_xlat23;
    u_xlat23 = min(u_xlat15.x, u_xlat16_10);
    u_xlat13.x = dot(float3(-0.147, -0.289000005, 0.43599999), _kMetallicTint.xyz);
    u_xlat13.y = dot(float3(0.61500001, -0.514999986, -0.100000001), _kMetallicTint.xyz);
    DiffuseIBLColor.yz = (u_xlat23) * u_xlat13.xy;
    u_xlat6.x = dot(float2(1.0, 1.13999999), DiffuseIBLColor.xz);
    u_xlat6.y = dot(float3(1.0, -0.395000011, -0.58099997), DiffuseIBLColor.xyz);
    u_xlat6.z = dot(float2(1.0, 2.03200006), DiffuseIBLColor.xy);



    DiffuseIBLColor.xyz = (kMetallicCoverage) * u_xlat6.xyz;
    DiffuseIBLColor.xyz = DiffuseIBLColor.xyz * (_kMetallicBoost);
    u_xlat10.xyz = (u_xlat17) * DiffuseIBLColor.xyz;


    kMetallicCoverage = u_xlat15.x * -5.55472994 + -6.98316002;


    u_xlat15.x = u_xlat15.x * kMetallicCoverage;
    u_xlat15.x = exp2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * u_xlat3.x;
    kMetallicCoverage = (-_kClearCoatShininess) * 3.0 + 4.0;
    u_xlat15.x = u_xlat15.x / kMetallicCoverage;
    u_xlat15.x = u_xlat15.x + _kClearCoatF0;
    kMetallicCoverage = u_xlat15.x + -0.25;


#ifdef UNITY_ADRENO_ES3
    kMetallicCoverage = min(max(kMetallicCoverage, 0.0), 1.0);
#else
    kMetallicCoverage = clamp(kMetallicCoverage, 0.0, 1.0);
#endif

  

    u_xlat23 = u_xlat10_5.w * u_xlat23;
  
    kMetallicCoverage = u_xlat15.x * u_xlat23 + kMetallicCoverage;
    kMetallicCoverage = max(kMetallicCoverage, 0.0);
    DiffuseIBLColor.xyz = (kMetallicCoverage) * u_xlat10_5.xyz;
    u_xlat3.xyz = DiffuseIBLColor.xyz * u_xlat15.xxx + u_xlat10.xyz;

    u_xlat15.x = (-u_xlat15.x) + 1.0;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;






    DiffuseIBLColor = IBL.xyz * _kDiffuseTint;

    u_xlat3.xyz = DiffuseIBLColor.xyz * u_xlat15.x + u_xlat3.xyz;
    u_xlat10_4.xyz = tex2D(_AuxTex1, uv).xyz;
    u_xlat16_15.xy = (-u_xlat10_4.xy) + float2(1.0, 1.0);
    u_xlat16_22 = u_xlat16_15.y * 6.0;
    u_xlat8 = max(u_xlat16_8, u_xlat16_22);

   float4 spl = texCUBElod(_SpecAmbientMap, float4(u_xlat2.xyz, u_xlat8));

    u_xlat8 = u_xlat0.x * -5.55472994 + -6.98316002;

    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_15.x;
    u_xlat16_8 = (-u_xlat10_4.y) * 3.0 + 4.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;

    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
    u_xlat8 = u_xlat10_4.z * VertexColor.y;
    u_xlat15.x = u_xlat0.x + -0.25;



#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif

    kMetallicCoverage = (-u_xlat15.x) * 1.33333302 + 1.0;

    u_xlat15.x = u_xlat15.x * 1.33333302;

    kMetallicCoverage = spl.w * kMetallicCoverage;


    u_xlat15.x = (kMetallicCoverage * 6.0 + u_xlat15.x)  + -0.25;
  
    kMetallicCoverage = (-u_xlat15.x) + 1.0;


    u_xlat15.x = u_xlat0.x * kMetallicCoverage + u_xlat15.x;
    u_xlat15.x = max(u_xlat15.x, 0.0);
    u_xlat2.xyz = u_xlat15.x * spl.xyz;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;



    u_xlat0.x = (-u_xlat0.x) + 1.0;

    u_xlat1.xzw = u_xlat1.x* u_xlat2.xyz;


    float3 Diffuse = tex2D(_MainTex, uv).xyz;

    float3 finaldiffuse = IBL.xyz * Diffuse;

    u_xlat0.xyz = finaldiffuse* u_xlat0.x+ u_xlat1.xzw;
    u_xlat0.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = (u_xlat8) * u_xlat0.xyz + u_xlat3.xyz;

    float v_color = VertexColor.r * _gkVehicleExposure;

    float4 SV_Target0;
    SV_Target0.xyz = v_color * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return SV_Target0;

			}
			ENDCG
		}
	}
}
