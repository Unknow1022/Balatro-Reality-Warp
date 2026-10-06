#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.0){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;
    float scale = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - mid_dist))
                * hovering * (length(mouse_offset) * length(mouse_offset)) / (2.0 - mid_dist);

    return transform_projection * vertex_position + vec4(0.0, 0.0, 0.0, scale);
}
#endif

#ifdef PIXEL
extern PRECISION vec2 astronomical;
extern PRECISION float time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern PRECISION float dissolve;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.0) : tex.xyz, shadow ? tex.a * 0.3 : tex.a);
    }

    float adjusted_dissolve = (dissolve * dissolve * (3.0 - 2.0 * dissolve)) * 1.02 - 0.01;

    float t = time * 10.0 + 2003.0;
    vec2 floored_uv = (floor((uv * texture_details.ba))) / max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

    vec2 field_part1 = uv_scaled_centered + 50.0 * vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.0 * vec2(cos(t / 53.1532),  cos(t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.0 * vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.0 + (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) )) / 2.0;
    vec2 borders = vec2(0.2, 0.8);

    float res = (0.5 + 0.5 * cos((adjusted_dissolve) / 82.612 + (field - 0.5) * 3.14159265))
        - (floored_uv.x > borders.y ? (floored_uv.x - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (floored_uv.y > borders.y ? (floored_uv.y - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (floored_uv.x < borders.x ? (borders.x - floored_uv.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (floored_uv.y < borders.x ? (borders.x - floored_uv.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve;

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.0) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a * 0.3 : tex.a) : 0.0);
}

// Pseudo-random 2D hash
float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    if (tex.a <= 0.0) {
        return vec4(0.0);
    }

    vec2 uv = (((texture_coords) * (image_details)) - texture_details.xy * texture_details.ba) / texture_details.ba;

    float t = time * 0.8 + astronomical.y * 0.4;
    float lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    float min_c = min(tex.r, min(tex.g, tex.b));
    float max_c = max(tex.r, max(tex.g, tex.b));
    float sat_diff = max_c - min_c;

    // Detect black and gray borders/outlines/shading
    // 1. Dark black outlines & borders (lum < 0.24)
    // 2. Neutral grays (low saturation diff and non-white lum < 0.78)
    float is_dark = 1.0 - smoothstep(0.10, 0.24, lum);
    float is_gray = (1.0 - smoothstep(0.04, 0.18, sat_diff)) * (1.0 - smoothstep(0.55, 0.78, lum)) * smoothstep(0.12, 0.25, lum);
    float is_border = clamp(is_dark + is_gray, 0.0, 1.0);

    // Deep outer space blue & cosmic radiant yellow palette
    vec3 cosmos_deep = vec3(0.03, 0.06, 0.28);     // Midnight abyss blue
    vec3 cosmos_royal = vec3(0.08, 0.24, 0.72);    // Deep space royal blue
    vec3 cosmos_cyan = vec3(0.15, 0.62, 0.95);     // Glowing nebula blue
    vec3 cosmos_yellow = vec3(1.00, 0.88, 0.18);   // Radiant solar star yellow
    vec3 cosmos_amber = vec3(1.00, 0.70, 0.06);    // Deep stellar amber yellow

    // Subtle cosmic nebula swirl in the space background
    vec2 center = vec2(0.5, 0.5);
    vec2 pos = uv - center;
    float dist = length(pos);
    float angle = atan(pos.y, pos.x);
    float swirl = sin(angle * 2.0 - dist * 6.0 + t) * 0.5 + 0.5;

    // Replace all card colors strictly with blues and yellows based on brightness & warmth
    vec3 space_blue = mix(cosmos_deep, cosmos_royal, clamp(lum * 1.5, 0.0, 1.0));
    space_blue = mix(space_blue, cosmos_cyan, swirl * 0.4);
    
    // Highlights and warm tones map to radiant cosmic yellow
    float yellow_factor = smoothstep(0.52, 0.85, lum) * (0.6 + 0.4 * sin(uv.x * 4.0 + uv.y * 3.0 + t));
    vec3 space_colored = mix(space_blue, mix(cosmos_amber, cosmos_yellow, swirl), yellow_factor);

    // Reduced procedural starfield layers for a clean, elegant celestial look
    // Layer 1: Subtle sparse micro-starfield
    vec2 grid1 = floor(uv * 32.0);
    float h1 = hash21(grid1);
    float twinkle1 = sin(t * 3.0 + h1 * 6.283) * 0.5 + 0.5;
    float stars1 = step(0.965, h1) * twinkle1 * 0.75;

    // Layer 2: Sparse sparkling stars
    vec2 grid2 = floor(uv * 18.0);
    vec2 p2 = fract(uv * 18.0) - 0.5;
    float h2 = hash21(grid2);
    float twinkle2 = sin(t * 2.0 + h2 * 6.283 + 1.2) * 0.5 + 0.5;
    float star_core2 = max(0.0, 1.0 - length(p2) * 3.5);
    float stars2 = step(0.955, h2) * star_core2 * twinkle2;

    // Layer 3: Rare 4-pointed cross diffraction stars
    vec2 grid3 = floor(uv * 9.0);
    vec2 p3 = fract(uv * 9.0) - 0.5;
    float h3 = hash21(grid3);
    float twinkle3 = sin(t * 1.6 + h3 * 6.283 + 2.5) * 0.5 + 0.5;
    float cross = max(0.0, 1.0 - abs(p3.x) * 9.0) * max(0.0, 1.0 - abs(p3.y) * 2.0)
                + max(0.0, 1.0 - abs(p3.y) * 9.0) * max(0.0, 1.0 - abs(p3.x) * 2.0);
    float stars3 = step(0.96, h3) * cross * twinkle3 * 1.1;

    float all_stars = stars1 + stars2 + stars3;

    // Apply color replacement (blues and yellows)
    vec3 final_rgb = mix(tex.rgb, space_colored, 0.78);

    // Convert black and gray borders to glowing celestial white
    final_rgb = mix(final_rgb, vec3(1.0, 1.0, 1.0), is_border * 0.95);

    // Add bright twinkling starlight
    vec3 star_color = mix(vec3(1.0, 1.0, 1.0), cosmos_yellow, 0.25);
    final_rgb += star_color * all_stars;

    vec4 final_tex = vec4(final_rgb, tex.a);
    return dissolve_mask(final_tex * colour, texture_coords, uv);
}
#endif
