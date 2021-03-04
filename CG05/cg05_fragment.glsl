precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;
varying vec2 vUv;
uniform sampler2D texture;


vec2 PhongDir(vec3 lightDir, float lightInt, float Ka, float Kd, float Ks, float shininess)
	{
	vec3 s = normalize(lightDir);
	vec3 v = normalize(-fPosition);
	vec3 n = normalize(fNormal);
	vec3 r = normalize(reflect(-s,n));
	float diffuse = Ka + Kd * lightInt * max(0.0, dot(n, s));
	float spec =  Ks * pow(max(0.0, dot(r,v)), shininess);
	return vec2(diffuse, spec);
	}

void main()
{
    vec3 lightDir = vec3(1.0, 1.0, 1.0);
	vec2 ds = PhongDir(lightDir, 1.0, 0.0, 0.5, 1.0, 100.0);
	float brightness = ds.x + ds.y;

    float color;

    float intensity = dot(lightDir,normalize(fNormal));

	if (brightness > 0.27)
        color = 0.9;
    else
        color = 0.6;

    gl_FragColor = color * texture2D(texture, vUv);
}