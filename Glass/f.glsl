#version 300 es

precision highp float;
precision highp int;
uniform     vec2 _gkVehicleExposure;
uniform     float _gkAliasDimming;
uniform     float _kf0;
uniform     float _kShininess;
uniform lowp sampler2D _AuxTex2;
uniform lowp sampler2D _AuxTex1;
uniform lowp samplerCube _DiffAmbientMap;
uniform lowp samplerCube _SpecAmbientMap;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
float u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec4 u_xlat10_4;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
float u_xlat8;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
float u_xlat18;
float u_xlat19;
float u_xlat20;
lowp float u_xlat10_20;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD0.xyz;
    u_xlat18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD2.xyz;
    u_xlat18 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = u_xlat18 * -5.55472994 + -6.98316002;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat18 = exp2(u_xlat18);
    u_xlat10_2.xyz = texture(_AuxTex2, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xyz = (-u_xlat10_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat19 = u_xlat18 * u_xlat16_3.x;
    u_xlat16_8 = (-u_xlat10_2.y) * 3.0 + 4.0;
    u_xlat19 = u_xlat19 / u_xlat16_8;
    u_xlat19 = u_xlat19 + u_xlat10_2.x;
    u_xlat2 = u_xlat19 + -0.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2) * 1.33333302 + 1.0;
    u_xlat2 = u_xlat2 * 1.33333302;
    u_xlat20 = dot((-u_xlat0.xyz), u_xlat1.xyz);
    u_xlat20 = u_xlat20 + u_xlat20;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat20)) + (-u_xlat0.xyz);
    u_xlat10_1.xyz = texture(_DiffAmbientMap, u_xlat1.xyz).xyz;
    u_xlat10_20 = texture(_DiffAmbientMap, u_xlat0.xyz).w;
    u_xlat16_3.x = u_xlat10_20 * 15.9375;
    u_xlat20 = (-u_xlat10_20) * _gkAliasDimming + 1.0;
    u_xlat16_9 = u_xlat16_3.y * 6.0;
    u_xlat9 = max(u_xlat16_3.x, u_xlat16_9);
    u_xlat10_4 = textureLod(_SpecAmbientMap, u_xlat0.xyz, u_xlat9);
    u_xlat8 = u_xlat8 * u_xlat10_4.w;
    u_xlat2 = u_xlat8 * 6.0 + u_xlat2;
    u_xlat2 = u_xlat2 + -0.25;
    u_xlat8 = (-u_xlat2) + 1.0;
    u_xlat2 = u_xlat19 * u_xlat8 + u_xlat2;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat4.xyz = vec3(u_xlat2) * u_xlat10_4.xyz;
    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat4.xyz = vec3(u_xlat20) * u_xlat4.xyz;
    u_xlat10_5.xyz = texture(_AuxTex1, vs_TEXCOORD1.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat10_5.xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(u_xlat19) + u_xlat4.xyz;
    u_xlat1.xyz = u_xlat10_2.zzz * u_xlat1.xyz;
    u_xlat19 = (-_kShininess) + 1.0;
    u_xlat19 = u_xlat19 * 6.0;
    u_xlat19 = max(u_xlat16_3.x, u_xlat19);
    u_xlat10_4 = textureLod(_SpecAmbientMap, u_xlat0.xyz, u_xlat19);
    u_xlat0.x = (-_kf0) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat18 + _kf0;
    u_xlat6.x = u_xlat0.x + -0.25;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat12 = (-u_xlat6.x) * 1.33333302 + 1.0;
    u_xlat6.x = u_xlat6.x * 1.33333302;
    u_xlat12 = u_xlat10_4.w * u_xlat12;
    u_xlat6.x = u_xlat12 * 6.0 + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + -0.25;
    u_xlat12 = (-u_xlat6.x) + 1.0;
    u_xlat6.x = u_xlat0.x * u_xlat12 + u_xlat6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_3.z;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat10_4.xyz;
    u_xlat19 = u_xlat20 * u_xlat0.x;
    SV_Target0.w = u_xlat0.x * u_xlat20 + u_xlat10_2.z;
    u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vec3(_gkVehicleExposure.x, _gkVehicleExposure.x, _gkVehicleExposure.x);
    return;
}