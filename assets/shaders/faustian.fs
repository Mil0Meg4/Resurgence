#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif


extern PRECISION vec2 faustian;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

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

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}
extern PRECISION float lines_offset;

vec4 dissolve_mask(vec4 final_pixel, vec2 texture_coords, vec2 uv);


vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
    vec4 tex = Texel( texture, texture_coords);

    vec2 adjusted_uv = uv - vec2(1.2, -0.1);
    adjusted_uv.x = adjusted_uv.x*texture_details.b/texture_details.a;

    number low = min(tex.r, min(tex.g, tex.b));
    number high = max(tex.r, max(tex.g, tex.b));
	number delta = min(high, max(0.6, 1. - low));

    number fac = 0.8 + 0.9*sin(11.*uv.x+4.32*uv.y + faustian.r*12. + cos(faustian.r*5.3 + uv.y*4.2 - uv.x*4.));
    number fac2 = 0.5 + 0.5*sin(8.*uv.x+2.32*uv.y + faustian.r*5. - cos(faustian.r*2.3 + uv.x*8.2));
    number fac3 = 0.5 + 0.5*sin(10.*uv.x+5.32*uv.y + faustian.r*6.111 + sin(faustian.r*5.3 + uv.y*3.2));
    number fac4 = 0.5 + 0.5*sin(3.*uv.x+2.32*uv.y + faustian.r*8.111 + sin(faustian.r*1.3 + uv.y*11.2));
    number fac5 = sin(0.9*16.*uv.x+5.32*uv.y + faustian.r*12. + cos(faustian.r*5.3 + uv.y*4.2 - uv.x*4.));

    number maxfac = 0.25*max(max(fac, max(fac2, max(fac3,0.0))) + (fac+fac2+fac3*fac4), 0.);

    tex.g = tex.g-delta + delta*maxfac*(0.7 - fac5*0.27) - 0.2;
    tex.r = tex.r-delta + delta*maxfac*(0.7 - fac5*0.27) + 0.3;
    tex.b = tex.b-delta + delta*maxfac*(0.7 - fac5*0.27) - 0.2;
    ///////
    float sprite_width = texture_details.z / image_details.x; // Normalized width
    float min_x = texture_details.x * sprite_width; // min X
    float max_x = (texture_details.x + 1.) * sprite_width; // max X

    float tilt_normalized = faustian.x;

    float t = faustian.y*2.221 + time;
    float t2 = t/2.3;
    float q4 = sin(t2*0.8); // pulsing function

    float shiftX = 2.5 * sin(uv.y * (10.16 + 25 * uv.y * uv.y) + tilt_normalized * 1.5) // sine shift + affected by card rotation
                                            / image_details.x; // shift X so normalize by X

    float border = (1-pow(abs(((0.5-uv.x))*2),2));
    float newX = min(max_x, max(min_x, texture_coords.x + shiftX*border*1.5*q4));
    
    vec2 offset = 1/image_details*vec2(1,0);

	number saturation_fac = 1. - max(0., 0.05*(1.1-delta));
	
	vec4 hsl = HSL(vec4(tex.r*saturation_fac, tex.g*saturation_fac, tex.b, tex.a));

	vec2 floored_uv = (floor((uv*texture_details.ba)))/texture_details.ba;
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 50.;
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 13.6340), cos(-t / 9.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 5.1532),  cos( t / 6.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 8.53218), sin(-t / 4.0000));

    float field = (1.+ (cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
    cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;

	float q6 = (t2 - floor(t2)); // pulsing function
	q6 = q6*q6;
	q6 = q6*q6;

	float q3 = 2.0 * (floor(0.5 + t2/2.0) - floor(t2/2.0)) - 1;
	float res = (q3*q6 - floor(q3*q6)) + (1-(q3*q6 - floor(q3*q6)))*(1); // transparency

    hsl.x = 0.08;
	hsl.y = 0.7;
	hsl.z = (0.8*hsl.z + res*res*0.2) * (0.3 + uv.y);
	float qalph = 0.66 + res/3;

    tex.rgb = RGB(hsl).rgb;

    //vec4 pixel = Texel(texture, texture_coords);
    vec4 pixel = Texel(texture, vec2(newX, texture_coords.y));

    pixel = vec4(pixel.rgb * 0.66 + tex.rgb * tex.a, pixel.a * qalph);
    /////
    if (uv.x > 2. * uv.x) {
        uv = faustian;
    }


    return dissolve_mask(tex*pixel, texture_coords, uv);
}

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