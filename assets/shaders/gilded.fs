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
extern PRECISION vec2 gilded;
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

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    if (tex.a <= 0.0) {
        return vec4(0.0);
    }

    vec2 uv = (((texture_coords) * (image_details)) - texture_details.xy * texture_details.ba) / texture_details.ba;

    // Detect white / off-white colors to preserve them completely unaffected
    float min_c = min(tex.r, min(tex.g, tex.b));
    float max_c = max(tex.r, max(tex.g, tex.b));
    float sat_diff = max_c - min_c;
    // High brightness with very low color saturation = white / near-white
    float is_white = smoothstep(0.74, 0.88, min_c) * (1.0 - smoothstep(0.05, 0.18, sat_diff));

    // Rich golden & vibrant yellow metallic sheen
    float t = time * 2.2 + gilded.y * 0.8;
    float diagonal = uv.x * 1.6 + uv.y * 0.9;

    float sheen1 = pow(sin(diagonal * 5.0 - t + gilded.x * 0.1) * 0.5 + 0.5, 3.5);
    float sheen2 = pow(sin(diagonal * 11.0 - t * 1.5 + 1.2) * 0.5 + 0.5, 7.0);
    float micro_grain = sin(uv.x * 70.0 + uv.y * 35.0) * cos(uv.x * 35.0 - uv.y * 70.0) * 0.06;

    // Saturated 24K yellow-gold palette
    vec3 gold_deep = vec3(0.86, 0.52, 0.02);    // Rich amber gold
    vec3 gold_mid = vec3(1.00, 0.80, 0.08);     // Vibrant warm yellow gold
    vec3 gold_bright = vec3(1.00, 0.94, 0.28);  // Intense glowing yellow highlight
    vec3 gold_flash = vec3(1.00, 0.98, 0.60);   // Pure metallic gold specular

    vec3 base_gold = mix(gold_deep, gold_mid, uv.y + micro_grain);
    base_gold = mix(base_gold, gold_bright, sheen1);
    base_gold += gold_flash * (sheen2 * 0.6);

    // Apply intense yellow-gold tint ONLY to non-white areas
    float gold_strength = (1.0 - is_white) * (0.52 + 0.26 * sheen1);
    vec3 final_rgb = mix(tex.rgb, base_gold, gold_strength);
    
    // Subtle specular glint across the card (doesn't yellow white areas)
    final_rgb += (is_white > 0.5 ? vec3(1.0) : gold_flash) * (sheen2 * 0.22);

    vec4 final_tex = vec4(final_rgb, tex.a);
    return dissolve_mask(final_tex * colour, texture_coords, uv);
}
#endif
