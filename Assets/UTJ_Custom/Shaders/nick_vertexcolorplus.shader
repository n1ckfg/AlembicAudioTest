// http://answers.unity3d.com/questions/923726/unity-5-standard-shader-support-for-vertex-colors.html

Shader "Nick/VertexColorPlus" {

	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_BumpTex("Normal", 2D) = "bump" {}
		_SpecTex("Specular", 2D) = "white" {}
		_Glossiness ("Smoothness", Float) = 0.5
		_Metallic ("Metallic", Float) = 0.0
		_RimPower("Rim Power", Float) = 3.0
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
         
		CGPROGRAM
		#pragma surface surf Standard vertex:vert fullforwardshadows
		#pragma target 3.0
	
		struct Input {
			float2 uv_MainTex;
			float3 vertexColor; // Vertex color stored here by vert() method
			float3 viewDir;
		};
         
		struct v2f {
			float4 pos : SV_POSITION;
			fixed4 color : COLOR;
		};
 
		void vert (inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input,o);
			o.vertexColor = v.color; // Save the Vertex Color in the Input for the surf() method
		}
 
		sampler2D _MainTex;
		sampler2D _BumpTex;
		sampler2D _SpecTex;

		half _Glossiness;
		half _Metallic;
		half _RimPower;
		fixed4 _Color;
 
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb * IN.vertexColor; // Combine normal color with the vertex color
			o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_MainTex));
			half4 spec = tex2D(_SpecTex, IN.uv_MainTex);
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness * spec.rgb;

			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = IN.vertexColor * pow(rim, _RimPower);

			o.Alpha = c.a;
		}
		ENDCG
	} 

	FallBack "Diffuse"

 }