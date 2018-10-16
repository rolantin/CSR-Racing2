#version 300 es

uniform     vec3 _WorldSpaceCameraPos;
uniform     vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform     vec4 hlslcc_mtx4x4_bones[96];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_COLOR0.w * 255.0 + 0.100000001;
    u_xlat0 = floor(u_xlat0);
    u_xlati0 = int(u_xlat0);
    u_xlati0 = u_xlati0 << 2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4_bones[u_xlati0 + 1];
    u_xlat1 = hlslcc_mtx4x4_bones[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4_bones[u_xlati0 + 2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4_bones[u_xlati0 + 3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;

     //viewDirection

    vs_TEXCOORD0.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;

    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4_bones[u_xlati0 + 1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4_bones[u_xlati0].xyz * in_NORMAL0.xxx + u_xlat3.xyz;
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4_bones[u_xlati0 + 2].xyz * in_NORMAL0.zzz + u_xlat3.xyz;
    return;
}