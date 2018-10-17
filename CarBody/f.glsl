#version 300 es

precision highp float;
precision highp int;
uniform     vec2 _gkVehicleExposure;
uniform     float _gkAliasDimming;
uniform     float _kMetallicCoverage;
uniform     float _kMetallicShininess;
uniform     float _kClearCoatF0;
uniform     float _kClearCoatShininess;
uniform     vec3 _kDiffuseTint;
uniform     vec3 _kMetallicTint;
uniform     float _kFresnelPower;
uniform     float _kMetallicBoost;
uniform lowp sampler2D _AuxTex1;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _DiffAmbientMap;
uniform lowp samplerCube _SpecAmbientMap;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
lowp float u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
lowp vec4 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
lowp vec3 u_xlat10_7;
float u_xlat8;
mediump float u_xlat16_8;
vec3 u_xlat10;
mediump float u_xlat16_10;
vec2 u_xlat13;
vec2 u_xlat15;
mediump vec2 u_xlat16_15;
float u_xlat17;
float u_xlat21;
float u_xlat22;
mediump float u_xlat16_22;
float u_xlat23;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat21 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD1.xyz;
    u_xlat21 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat21)) + (-u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10_7.xyz = texture(_DiffAmbientMap, u_xlat1.xyz).xyz;
    u_xlat10_1 = texture(_DiffAmbientMap, u_xlat2.xyz).w;
    u_xlat16_8 = u_xlat10_1 * 15.9375;
    u_xlat1.x = (-u_xlat10_1) * _gkAliasDimming + 1.0;
    u_xlat3.xyz = vec3((-float(_kClearCoatF0)) + float(1.0), (-float(_kClearCoatShininess)) + float(1.0), (-float(_kMetallicShininess)) + float(1.0));
    u_xlat15.xy = vec2(u_xlat3.y * float(6.0), u_xlat3.z * float(6.0));
    u_xlat15.xy = max(vec2(u_xlat16_8), u_xlat15.xy);
    u_xlat10_4 = textureLod(_SpecAmbientMap, u_xlat2.xyz, u_xlat15.y);
    u_xlat10_5 = textureLod(_SpecAmbientMap, u_xlat2.xyz, u_xlat15.x);
    u_xlat15.x = log2(u_xlat0.x);
    u_xlat15.x = u_xlat15.x * _kFresnelPower;
    u_xlat15.x = exp2(u_xlat15.x);
    u_xlat22 = u_xlat15.x * _kMetallicCoverage + -0.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat22) * 1.33333302 + 1.0;
    u_xlat22 = u_xlat22 * 1.33333302;
    u_xlat23 = u_xlat10_4.w * u_xlat23;
    u_xlat16_10 = dot(vec3(0.298999995, 0.587000012, 0.114), u_xlat10_4.xyz);
    u_xlat22 = u_xlat23 * 6.0 + u_xlat22;
    u_xlat22 = u_xlat22 + -0.25;
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat17 = u_xlat15.x * _kMetallicCoverage;
    u_xlat22 = u_xlat17 * u_xlat23 + u_xlat22;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat23 = dot(vec3(0.298999995, 0.587000012, 0.114), _kMetallicTint.xyz);
    u_xlat4.x = u_xlat16_10 * u_xlat23;
    u_xlat23 = min(u_xlat15.x, u_xlat16_10);
    u_xlat13.x = dot(vec3(-0.147, -0.289000005, 0.43599999), _kMetallicTint.xyz);
    u_xlat13.y = dot(vec3(0.61500001, -0.514999986, -0.100000001), _kMetallicTint.xyz);
    u_xlat4.yz = vec2(u_xlat23) * u_xlat13.xy;
    u_xlat6.x = dot(vec2(1.0, 1.13999999), u_xlat4.xz);
    u_xlat6.y = dot(vec3(1.0, -0.395000011, -0.58099997), u_xlat4.xyz);
    u_xlat6.z = dot(vec2(1.0, 2.03200006), u_xlat4.xy);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_kMetallicBoost);
    u_xlat10.xyz = vec3(u_xlat17) * u_xlat4.xyz;
    u_xlat22 = u_xlat15.x * -5.55472994 + -6.98316002;
    u_xlat15.x = u_xlat15.x * u_xlat22;
    u_xlat15.x = exp2(u_xlat15.x);
    u_xlat15.x = u_xlat15.x * u_xlat3.x;
    u_xlat22 = (-_kClearCoatShininess) * 3.0 + 4.0;
    u_xlat15.x = u_xlat15.x / u_xlat22;
    u_xlat15.x = u_xlat15.x + _kClearCoatF0;
    u_xlat22 = u_xlat15.x + -0.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat23 = (-u_xlat22) * 1.33333302 + 1.0;
    u_xlat22 = u_xlat22 * 1.33333302;
    u_xlat23 = u_xlat10_5.w * u_xlat23;
    u_xlat22 = u_xlat23 * 6.0 + u_xlat22;
    u_xlat22 = u_xlat22 + -0.25;
    u_xlat23 = (-u_xlat22) + 1.0;
    u_xlat22 = u_xlat15.x * u_xlat23 + u_xlat22;
    u_xlat22 = max(u_xlat22, 0.0);
    u_xlat4.xyz = vec3(u_xlat22) * u_xlat10_5.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat15.xxx + u_xlat10.xyz;
    u_xlat15.x = (-u_xlat15.x) + 1.0;
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat4.xyz = u_xlat10_7.xyz * _kDiffuseTint.xyz;
    u_xlat3.xyz = u_xlat4.xyz * u_xlat15.xxx + u_xlat3.xyz;
    u_xlat10_4.xyz = texture(_AuxTex1, vs_TEXCOORD3.xy).xyz;
    u_xlat16_15.xy = (-u_xlat10_4.xy) + vec2(1.0, 1.0);
    u_xlat16_22 = u_xlat16_15.y * 6.0;
    u_xlat8 = max(u_xlat16_8, u_xlat16_22);
    u_xlat10_2 = textureLod(_SpecAmbientMap, u_xlat2.xyz, u_xlat8);
    u_xlat8 = u_xlat0.x * -5.55472994 + -6.98316002;
    u_xlat0.x = u_xlat0.x * u_xlat8;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat16_15.x;
    u_xlat16_8 = (-u_xlat10_4.y) * 3.0 + 4.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
    u_xlat8 = u_xlat10_4.z * vs_TEXCOORD2.y;
    u_xlat15.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat15.x = min(max(u_xlat15.x, 0.0), 1.0);
#else
    u_xlat15.x = clamp(u_xlat15.x, 0.0, 1.0);
#endif
    u_xlat22 = (-u_xlat15.x) * 1.33333302 + 1.0;
    u_xlat15.x = u_xlat15.x * 1.33333302;
    u_xlat22 = u_xlat10_2.w * u_xlat22;
    u_xlat15.x = u_xlat22 * 6.0 + u_xlat15.x;
    u_xlat15.x = u_xlat15.x + -0.25;
    u_xlat22 = (-u_xlat15.x) + 1.0;
    u_xlat15.x = u_xlat0.x * u_xlat22 + u_xlat15.x;
    u_xlat15.x = max(u_xlat15.x, 0.0);
    u_xlat2.xyz = u_xlat15.xxx * u_xlat10_2.xyz;
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xzw = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat10_7.xyz * u_xlat10_2.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat0.xxx + u_xlat1.xzw;
    u_xlat0.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(u_xlat8) * u_xlat0.xyz + u_xlat3.xyz;
    u_xlat21 = vs_TEXCOORD2.x * _gkVehicleExposure.xxxy.z;
    SV_Target0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}