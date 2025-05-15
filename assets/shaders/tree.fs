#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

#define MAXDIST 50
// !! change this variable name to your Shader's name
// YOU MUST USE THIS VARIABLE IN THE vec4 effect AT LEAST ONCE

// Values of this variable:
// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 tree;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply  
//        it by sprite_width _height (look flipped.fs)
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

struct Ray {
	vec3 ro;
    vec3 rd;
};
  
// from netgrind
vec3 hue(vec3 color, float shift) {

    const vec3  kRGBToYPrime = vec3 (0.299, 0.587, 0.114);
    const vec3  kRGBToI     = vec3 (0.596, -0.275, -0.321);
    const vec3  kRGBToQ     = vec3 (0.212, -0.523, 0.311);

    const vec3  kYIQToR   = vec3 (1.0, 0.956, 0.621);
    const vec3  kYIQToG   = vec3 (1.0, -0.272, -0.647);
    const vec3  kYIQToB   = vec3 (1.0, -1.107, 1.704);

    // Convert to YIQ
    float   YPrime  = dot (color, kRGBToYPrime);
    float   I      = dot (color, kRGBToI);
    float   Q      = dot (color, kRGBToQ);

    // Calculate the hue and chroma
    float   hue     = atan (Q, I);
    float   chroma  = sqrt (I * I + Q * Q);

    // Make the user's adjustments
    hue += shift;

    // Convert back to YIQ
    Q = chroma * sin (hue);
    I = chroma * cos (hue);

    // Convert back to RGB
    vec3    yIQ   = vec3 (YPrime, I, Q);
    color.r = dot (yIQ, kYIQToR);
    color.g = dot (yIQ, kYIQToG);
    color.b = dot (yIQ, kYIQToB);

    return color;
}

// ------

// by iq

float opU( float d1, float d2 )
{
    return min(d1,d2);
}

float smin( float a, float b, float k ){
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return mix( b, a, h ) - k*h*(1.0-h);
}

float length6( vec3 p )
{
	p = p*p*p; p = p*p;
	return pow( p.x + p.y + p.z, 1.0/6.5 );
}

// ------

// from hg_sdf 

float fPlane(vec3 p, vec3 n, float distanceFromOrigin) {
	return dot(p, n) + distanceFromOrigin;
}

void pR(inout vec2 p, float a) {
	p = cos(a)*p + sin(a)*vec2(p.y, -p.x);
}

// -------


float fractal(vec3 p)
{
    const int iterations = 20;
	
    float d = time*5. - p.z;
   	p=p.yxz;
    pR(p.yz, 1.570795);
    p.x += 6.5;

    p.yz = mod(abs(p.yz)-.0, 20.) - 10.;
    float scale = 1.25;
    
    p.xy /= (1.+d*d*0.0005);
    
	float l = 0.;
	
    for (int i=0; i<iterations; i++) {
		p.xy = abs(p.xy);
		p = p*scale + vec3(-3. + d*0.0095,-1.5,-.5);
        
		pR(p.xy,0.35-d*0.015);
		pR(p.yz,0.5+d*0.02);
		
        l =length6(p);
	}
	return l*pow(scale, -float(iterations))-.15;
}

vec2 map(vec3 pos) 
{
    float dist = 10.; 
    dist = opU(dist, fractal(pos));
    dist = smin(dist, fPlane(pos,vec3(0.0,1.0,0.0),10.), 4.6);
    return vec2(dist, 0.);
}

vec3 vmarch(Ray ray, float dist)
{   
    vec3 p = ray.ro;
    vec2 r = vec2(0.);
    vec3 sum = vec3(0);
    vec3 c = hue(vec3(0.,0.,1.),5.5);
    for( int i=0; i<20; i++ )
    {
        r = map(p);
        if (r.x > .01) break;
        p += ray.rd*.015;
        vec3 col = c;
        col.rgb *= smoothstep(.0,0.15,-r.x);
        sum += abs(col)*.5;
    }
    return sum;
}

vec2 march(Ray ray) 
{
    const int steps = 50;
    const float prec = 0.001;
    vec2 res = vec2(0.);
    
    for (int i = 0; i < steps; i++) 
    {        
        vec2 s = map(ray.ro + ray.rd * res.x);
        
        if (res.x > MAXDIST || s.x < prec) 
        {
        	break;    
        }
        
        res.x += s.x;
        res.y = s.y;
        
    }
   
    return res;
}

vec3 calcNormal(vec3 pos) 
{
	const vec3 eps = vec3(0.005, 0.0, 0.0);
                          
    return normalize(
        vec3(map(pos + eps).x - map(pos - eps).x,
             map(pos + eps.yxz).x - map(pos - eps.yxz).x,
             map(pos + eps.yzx).x - map(pos - eps.yzx).x ) 
    );
}

vec4 render(Ray ray) 
{
    vec3 col = vec3(0.);
	vec2 res = march(ray);
   
    if (res.x > MAXDIST) 
    {
        return vec4(col, 50.);
    }
    
    vec3 pos = ray.ro+res.x*ray.rd;
    ray.ro = pos;
   	col = vmarch(ray, res.x);
    
    col = mix(col, vec3(0.), clamp(res.x/50., 0., 1.));
   	return vec4(col, res.x);
}

mat3 camera(in vec3 ro, in vec3 rd, float rot) 
{
	vec3 forward = normalize(rd - ro);
    vec3 worldUp = vec3(sin(rot), cos(rot), 0.0);
    vec3 x = normalize(cross(forward, worldUp));
    vec3 y = normalize(cross(x, forward));
    return mat3(x, y, forward);
}

// [Required] 
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // Take pixel color (rgba) from `texture` at `texture_coords`, equivalent of texture2D in GLSL
    vec4 tex = Texel(texture, texture_coords);
    // Position of a pixel within the sprite
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    uv = uv * 1.5 - 0.6;
    uv.x *= (tex.x / tex.y)*1.5;
    uv.y -= uv.x*uv.x*0.15;
    uv.y = -uv.y;
    vec3 camPos = vec3(3., -1.5, time*5.);
    vec3 camDir = camPos+vec3(-1.25,0.1, 1.);
    mat3 cam = camera(camPos, camDir, 0.);
    vec3 rayDir = cam * normalize( vec3(uv, .8));
    
    Ray ray;
    ray.ro = camPos;
    ray.rd = rayDir;
    
    vec4 col = render(ray);

    if (uv.x > 2. * uv.x) {
        uv = tree;
    }

    vec4 final_color = vec4(1.-col.xyz,clamp(1.-col.w/MAXDIST, 0., 1.));
    // required
    return dissolve_mask(tex*final_color, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// for transforming the card while your mouse is on it
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif