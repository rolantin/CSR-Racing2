Shader "Unlit/CarBody"
{
	Properties
	{
		_AuxTex1 ("_AuxTex1", 2D) = "white" {}
		_MainTex ("_MainTex", 2D) = "white" {}
		_DiffAmbientMap ("_DiffAmbientMap", CUBE) = "sky" {}
		_SpecAmbientMap ("_SpecAmbientMap", CUBE) = "sky" {}
		_gkAliasDimming ("_gkAliasDimming", Range(0,1)) = 1

		//_kMetallicCoverage ("_kMetallicCoverage", Range(0,1)) = 1

		_kClearCoatF0 ("_kClearCoatF0", Range(1,1)) = 1
		_kClearCoatShininess ("_kClearCoatShininess", FLOAT) = 1
		_kFresnelPower ("_kFresnelPower", Range(0,3)) = 1
		//_kMetallicBoost ("_kMetallicBoost",Range(0,1)) = 1
		_kLiveryUVScale ("_kLiveryUVScale", FLOAT) = 1
		_kMetallicShininess ("_kMetallicShininess", Range(0,3)) = 1

		_gkVehicleExposure ("_gkVehicleExposure",Range(0,1)) = 1
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
			//#include  "../CGIncludes/RolantinCG.cginc"

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
			
				//float IBLw;
				
		
				//float3 u_xlat3;
			
				
				float4 u_xlat10_5;
				float3 u_xlat6;
			
				//float3 IBL;
				float u_xlat8;
				float u_xlat16_8;
				float3 u_xlat10;
				float u_xlat16_10;
				//float2 u_xlat13;
				float2 u_xlat15;
<<<<<<< HEAD
				float2 u_xlat16_15;
				float u_xlat17;
				float _normal;
				float finalr2;
				float u_xlat16_22;
				float finalr3;

				//viewdir.x = dot(viewDir, viewDir);
				//viewdir.x = rsqrt(viewdir.x);
				//viewdir.xyz = viewdir.x * viewDir;
			    float3 viewdir = normalize(viewDir);

			    //_normal = dot(NomalDir, NomalDir);
				//_normal = rsqrt(_normal);
				//normaldir.xyz = float3(_normal.xxx) * NomalDir;
				float4 normaldir; 
				normaldir.xyz = normalize(NomalDir);

///calcular Reflect
				_normal = dot(-viewdir, normaldir.xyz);
				_normal = _normal + _normal;

				finalr.xyz = normaldir.xyz *(-float3(_normal.xxx)) + (-viewdir);



				viewdir.x = dot(normaldir.xyz, viewdir);

				#ifdef UNITY_ADRENO_ES3
				viewdir.x = min(max(viewdir.x, 0.0), 1.0);
				#else
				viewdir.x = clamp(viewdir.x, 0.0, 1.0);
				#endif
				u_xlat10_7.xyz = texCUBE(_DiffAmbientMap, normaldir.xyz).xyz;
				u_xlat10_1 = texCUBE(_DiffAmbientMap, finalr.xyz).w;
				u_xlat16_8 = u_xlat10_1 * 15.9375;
				normaldir.x = (-u_xlat10_1)  * _gkAliasDimming + 1.0;
				u_xlat3.xyz = float3((-float(_kClearCoatF0)) + float(1.0), (-float(_kClearCoatShininess)) + float(1.0), (-float(_kMetallicShininess)) + float(1.0));
				u_xlat15.xy = float2(u_xlat3.y * float(6.0), u_xlat3.z * float(6.0));
				u_xlat15.xy = max(float2(u_xlat16_8,u_xlat16_8), u_xlat15.xy);

				u_xlat10_4 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat15.y));
				u_xlat10_5 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat15.x));

				u_xlat15.x = log2(viewdir.x);
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
				u_xlat3.xyz = normaldir.xxx * u_xlat3.xyz;
				u_xlat4.xyz = u_xlat10_7.xyz * _kDiffuseTint.xyz;
				u_xlat3.xyz = u_xlat4.xyz * u_xlat15.xxx + u_xlat3.xyz;
				u_xlat10_4.xyz = tex2D(_AuxTex1, uv).xyz;
				u_xlat16_15.xy = (-u_xlat10_4.xy) + float2(1.0, 1.0);
				u_xlat16_22 = u_xlat16_15.y * 6.0;
				u_xlat8 = max(u_xlat16_8, u_xlat16_22);
				u_xlat10_2 = texCUBElod(_SpecAmbientMap, float4(finalr.xyz, u_xlat8) );
				u_xlat8 = viewdir.x * -5.55472994 + -6.98316002;
				viewdir.x = viewdir.x * u_xlat8;
				viewdir.x = exp2(viewdir.x);
				viewdir.x = viewdir.x * u_xlat16_15.x;
				u_xlat16_8 = (-u_xlat10_4.y) * 3.0 + 4.0;
				viewdir.x = viewdir.x * u_xlat16_8;
				viewdir.x = viewdir.x + u_xlat10_4.x;
				u_xlat8 = u_xlat10_4.z * VertexColor.y;
				u_xlat15.x = viewdir.x + -0.25;
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
				u_xlat15.x = viewdir.x * finalr2 + u_xlat15.x;
				u_xlat15.x = max(u_xlat15.x, 0.0);
				finalr.xyz = u_xlat15.xxx * u_xlat10_2.xyz;
				finalr.xyz = viewdir.xxx * finalr.xyz;
				viewdir.x = (-viewdir.x) + 1.0;
				normaldir.xzw = normaldir.xxx*  finalr.xyz;
				u_xlat10_2.xyz = tex2D(_MainTex, uv).xyz;
				u_xlat16_7.xyz = u_xlat10_7.xyz * u_xlat10_2.xyz;
				viewdir.xyz = u_xlat16_7.xyz * viewdir.xxx + normaldir.xzw;
				viewdir.xyz = (-u_xlat3.xyz) + viewdir.xyz;
				viewdir.xyz = u_xlat8 * viewdir.xyz + u_xlat3.xyz;
				float3 light = DirectionalLight(i.vs_TEXCOORD1)[0];
				float4 SV_Target0;
				_normal = VertexColor.x * _gkVehicleExposure.xxxy.z;
				SV_Target0.xyz = _normal * viewdir.xyz ;
				SV_Target0.w = 1.0;
=======
				//float2 u_xlat16_15;
				//float u_xlat17;
				
				float kMetallicCoverage;
				//float u_xlat16_22;
				//float u_xlat23;

				
//u_xlat0.x = dot(viewDir.xyz, viewDir.xyz);
// u_xlat0.x = rsqrt(u_xlat0.x);
//  u_xlat0.xyz = u_xlat0.xxx * viewDir.xyz;
    float3 viewdir = normalize(viewDir);
 //normalize normal   
 //float normalx = dot(NomalDir.xyz, NomalDir.xyz);
 // normalx = rsqrt(normalx);
 //  float4 u_xlat1;
 //  u_xlat1.xyz = (normalx) * NomalDir.xyz;
   float3 normalx = normalize(NomalDir.xyz);
   float vdn = dot((-viewdir), normalx);
   float n2 = vdn + vdn;
   float3 viewdirx = normalx * (-(n2)) + (-viewdir);

  //  u_xlat0.x = dot(normalx, viewdirx);
//#ifdef UNITY_ADRENO_ES3
  //  u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
//#else
  //  u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
//#endif
   float3 IBL = texCUBE(_DiffAmbientMap, normalx);

  float  IBLw = texCUBE(_DiffAmbientMap, viewdirx.xyz).w;

   float IBLW  = IBLw * 15.9375;
>>>>>>> 3117451d02f9a06fbe47fdbe76e53daa9f5f7cf0

    float3 kAliasDimming = (-IBLw) * _gkAliasDimming + 1.0;

   // u_xlat1.x = (-IBLw) * _gkAliasDimming + 1.0;

   // u_xlat3.xyz = float3(_kClearCoatF0 , _kClearCoatShininess, (-float(_kMetallicShininess)) + float(1.0));

   // u_xlat15.xy = float2(_kClearCoatShininess * float(6.0), _kMetallicShininess * float(6.0));

    float ClearCoatShininess = _kClearCoatShininess * 6;

   // u_xlat15.xy = max((IBLw), u_xlat15.xy);

    float4 SBL = texCUBElod(_SpecAmbientMap,float4 (viewdirx.xyz, _kMetallicShininess * 6));



    u_xlat10_5 = texCUBElod(_SpecAmbientMap,float4(viewdirx.xyz, u_xlat15.x)) ;

    float nfe = log2(dot(normalx, viewdirx));

   // ClearCoatShininess = log2(dot(normalx, viewdirx));

    nfe = nfe * - _kFresnelPower;

    nfe = exp2(nfe);

    //kMetallicCoverage = (u_xlat15.x * _kMetallicCoverage + -0.25) * 1.33333302;
  // u_xlat23 = (-kMetallicCoverage) * 1.33333302 + 1.0;
  //  u_xlat23 = SBL.w * u_xlat23;
  //  u_xlat16_10 = dot(float3(0.298999995, 0.587000012, 0.114), SBL.xyz);
   // u_xlat17 = u_xlat15.x * _kMetallicCoverage;
  //  kMetallicCoverage = u_xlat17 * u_xlat23 + kMetallicCoverage;
    //u_xlat23 = dot(float3(0.298999995, 0.587000012, 0.114), _kMetallicTint.xyz);
   //float3 DiffuseIBLColor;
//DiffuseIBLColor.x = u_xlat16_10 * u_xlat23;
    //u_xlat23 = min(u_xlat15.x, u_xlat16_10);
   // u_xlat13.x = dot(float3(-0.147, -0.289000005, 0.43599999), _kMetallicTint.xyz);
   // u_xlat13.y = dot(float3(0.61500001, -0.514999986, -0.100000001), _kMetallicTint.xyz);
  //  DiffuseIBLColor.yz = (u_xlat23) * u_xlat13.xy;
   // u_xlat6.x = dot(float2(1.0, 1.13999999), DiffuseIBLColor.xz);
    //u_xlat6.y = dot(float3(1.0, -0.395000011, -0.58099997), DiffuseIBLColor.xyz);
   // u_xlat6.z = dot(float2(1.0, 2.03200006), DiffuseIBLColor.xy);
   // DiffuseIBLColor.xyz = (kMetallicCoverage) * u_xlat6.xyz;
   // DiffuseIBLColor.xyz = DiffuseIBLColor.xyz * (_kMetallicBoost);
   // u_xlat10.xyz = (u_xlat17) * DiffuseIBLColor.xyz;
//
  //  kMetallicCoverage = u_xlat15.x * -5.55472994 + -6.98316002;


   // u_xlat15.x = u_xlat15.x * kMetallicCoverage;
   // u_xlat15.x = exp2(u_xlat15.x);
   // u_xlat15.x = u_xlat15.x *_kClearCoatF0;
   // kMetallicCoverage = (-_kClearCoatShininess) * 3.0 + 4.0;
   // u_xlat15.x = u_xlat15.x / kMetallicCoverage;

   // u_xlat15.x = u_xlat15.x + _kClearCoatF0;
   // kMetallicCoverage = u_xlat15.x + -0.25;
//#ifdef UNITY_ADRENO_ES3
//    kMetallicCoverage = min(max(kMetallicCoverage, 0.0), 1.0);
//#else
    //kMetallicCoverage = clamp(kMetallicCoverage, 0.0, 1.0);
//#endif
   // u_xlat23 = u_xlat10_5.w * u_xlat23;
  
  //  kMetallicCoverage =  u_xlat15.x + _kClearCoatF0 * u_xlat23 + kMetallicCoverage;
   // kMetallicCoverage = max(kMetallicCoverage, 0.0);

    //DiffuseIBLColor.xyz = (kMetallicCoverage) * u_xlat10_5.xyz;
    //u_xlat3.xyz = DiffuseIBLColor.xyz * u_xlat15.xxx + u_xlat10.xyz;

    //u_xlat15.x = (-u_xlat15.x) + 1.0;

  //  u_xlat3.xyz = kAliasDimming * u_xlat3.xyz;
    //DiffuseIBLColor = IBL.xyz * _kDiffuseTint;

    float3 CarColor =  IBL.xyz * _kDiffuseTint;



    float vv =  nfe + _kClearCoatF0 ;

    float3 FIBL =  ClearCoatShininess *  CarColor * vv      * kAliasDimming;

   //     return float4 (FIBL,1);
     //u_xlat3.xyz = DiffuseIBLColor.xyz * ( ClearCoatShininess + _kClearCoatF0) ;
    float3 AuxTex_Var =  tex2D(_AuxTex1, uv);
   // u_xlat10_4.xyz = tex2D(_AuxTex1, uv).xyz;
   // u_xlat16_15.xy = (-AuxTex_Var.xy) + float2(1.0, 1.0);
   // u_xlat16_22 = (-AuxTex_Var.y+1) * 6.0;
   // u_xlat8 = max(IBLw, ((-AuxTex_Var.y+1) * 6.0));
   float4 spl = texCUBElod(_SpecAmbientMap , float4(viewdirx.xyz,  AuxTex_Var.y *_kMetallicShininess * 6 )) ;



   // u_xlat8 = u_xlat0.x * -5.55472994 + -6.98316002;

    //u_xlat0.x = u_xlat0.x * (u_xlat0.x * -5.55472994 + -6.98316002);

   // u_xlat0.x = exp2(u_xlat0.x);

   // u_xlat0.x = u_xlat0.x *( -AuxTex_Var.x +1);

   // IBLw = (-AuxTex_Var.y) * 3.0 + 4.0;

    //u_xlat0.x = ( ((exp2(u_xlat0.x))* ( -AuxTex_Var.x +1)) / ((-AuxTex_Var.y) * 3.0 + 4.0)) + AuxTex_Var.x;

    //u_xlat0.x = u_xlat0.x + AuxTex_Var.x;

   // u_xlat8 = AuxTex_Var.z * VertexColor.y;

    //ClearCoatShininess = u_xlat0.x + -0.25;

//#ifdef UNITY_ADRENO_ES3
 //   ClearCoatShininess = min(max(ClearCoatShininess, 0.0), 1.0);
//#else

  //  float ssd =  clamp( ClearCoatShininess -0.25, 0.0, 1.0);
  //  ClearCoatShininess =;
//#endif

  //  kMetallicCoverage = (-ssd) * 1.33333302 + 1.0;
  //  ssd  = ssd * 1.33333302;


  //  kMetallicCoverage = spl.w * kMetallicCoverage ;

 //  ssd = (kMetallicCoverage * 6.0 + ssd)  -0.25;
  
  //  kMetallicCoverage = (-ssd) + 1.0;


  //  ssd = ClearCoatShininess+  AuxTex_Var.x * kMetallicCoverage + ssd;
//
  // ssd = max(ssd, 0.0);


			// float3 todo
			//float3 splpower = ssd * spl.xyz *_kMetallicTint;
   float3 splpower =  spl.xyz * _kMetallicTint ;

			splpower = ClearCoatShininess * splpower;


			//u_xlat0.x = (-u_xlat0.x) + 1.0;

			float3 Fresnel =  kAliasDimming * splpower;
			// u_xlat1.xzw = kAliasDimming * splpower;

			float3 Maintex_Var = tex2D(_MainTex, uv).xyz;
			float3 finaldiffuse = IBL.xyz * Maintex_Var;

			u_xlat0.xyz = finaldiffuse* nfe + Fresnel;

//return float4(Fresnel,1);
			u_xlat0.xyz = (-FIBL) + u_xlat0.xyz;
             
  
			u_xlat0.xyz = (AuxTex_Var.z * VertexColor.g) * u_xlat0.xyz + FIBL;

			float v_colorR = VertexColor.r * _gkVehicleExposure;

			return float4((v_colorR * u_xlat0.xyz),1);

			}
			ENDCG
		}
	}
}
