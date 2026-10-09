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
extern PRECISION vec2 neon_grid;
extern PRECISION vec2 reality_warp_neon_grid;
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

// Helper to evaluate a dual-line grid layer
void get_layer_lines(vec2 uv, float scale, vec2 dir, float t, float sig, float glow_sig, out float bright_line, out float dim_line, out float glow, out float cross_node, out vec2 g_uv)
{
    g_uv = uv * scale + dir * t;
    vec2 cell = fract(g_uv);

    float dx1 = min(cell.x, 1.0 - cell.x);
    float dy1 = min(cell.y, 1.0 - cell.y);
    float dx2 = abs(cell.x - 0.192);
    float dy2 = abs(cell.y - 0.192);

    float lx1 = exp(-(dx1 * dx1) / (2.0 * sig * sig));
    float ly1 = exp(-(dy1 * dy1) / (2.0 * sig * sig));
    float lx2 = exp(-(dx2 * dx2) / (2.0 * sig * sig));
    float ly2 = exp(-(dy2 * dy2) / (2.0 * sig * sig));

    bright_line = max(lx1, ly1);
    dim_line = max(lx2, ly2);

    float gx = exp(-(dx1 * dx1) / (2.0 * glow_sig * glow_sig));
    float gy = exp(-(dy1 * dy1) / (2.0 * glow_sig * glow_sig));
    glow = max(gx, gy) * 0.35;
    cross_node = lx1 * ly1;
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    if (tex.a <= 0.0) {
        return vec4(0.0);
    }

    vec2 uv = (((texture_coords) * (image_details)) - texture_details.xy * texture_details.ba) / texture_details.ba;
    float aspect = texture_details.a / max(texture_details.b, 1.0);
    vec2 aspect_uv = vec2(uv.x, uv.y * aspect);

    // Dynamic timer combining engine time and shader vector (Supercharged loop mechanic)
    vec2 ng = (neon_grid.x != 0.0 || neon_grid.y != 0.0) ? neon_grid : reality_warp_neon_grid;
    float ng_osc = (ng.y != 0.0 ? ng.y : (ng.x != 0.0 ? ng.x : 0.0));
    float t = time * 3.5 + ng_osc * 1.5;
    float jitter = sin(t * 8.0) * 0.04;

    // =========================================================================
    // LAYER 1 (FRONT): Bright neon squares moving UP and LEFT with electric surge
    // =========================================================================
    float fb_line, fd_line, fglow, fcross;
    vec2 g_uv_front;
    vec2 dir_front = vec2(-0.35, -0.65); // UP and LEFT
    get_layer_lines(aspect_uv, 5.0, dir_front, t, 0.024, 0.075, fb_line, fd_line, fglow, fcross, g_uv_front);

    // Looping electric spark & pulse waves running through grid lines
    float pulse1 = abs(sin(g_uv_front.y * 3.14159 * 2.0 + t * 4.0 + jitter));
    float pulse2 = abs(cos(g_uv_front.x * 3.14159 * 2.0 - t * 3.0));
    float spark = pow(clamp(1.0 - min(pulse1, pulse2) * 2.2, 0.0, 1.0), 3.0);

    // Glowing grid node intersections with flashing bursts
    vec2 cell_id = floor(g_uv_front);
    float node_hash = sin(dot(cell_id, vec2(12.9898, 78.233))) * 43758.5453;
    float node_spark = pow(fcross, 1.4) * pow(sin(t * 6.0 + fract(node_hash) * 6.283) * 0.5 + 0.5, 3.0);

    // High voltage neon palette (Electric Cyan & Hot Magenta plasma)
    vec3 electric_cyan = vec3(0.10, 0.92, 1.00);
    vec3 hot_magenta   = vec3(1.00, 0.12, 0.70);
    vec3 core_white    = vec3(1.00, 1.00, 1.00);

    vec3 plasma = mix(hot_magenta, electric_cyan, sin(aspect_uv.x * 6.0 + t * 2.0) * 0.5 + 0.5);
    vec3 c_front_bright = plasma * (0.90 + 0.10 * sin(t * 4.0));
    vec3 c_front_mid    = mix(hot_magenta, electric_cyan, 0.5) * 0.45;

    vec3 front_rgb = c_front_bright * (fb_line + fglow) + c_front_mid * fd_line;
    front_rgb += core_white * ((spark * 0.90 + node_spark * 1.30) * (fb_line + 0.35));

    // =========================================================================
    // LAYER 2 (BACK): Darker purple/indigo cubes moving DOWN and RIGHT
    // =========================================================================
    float bb_line, bd_line, bglow, bcross;
    vec2 g_uv_back;
    vec2 dir_back = vec2(0.24, 0.48); // DOWN and RIGHT
    get_layer_lines(aspect_uv, 4.2, dir_back, t, 0.028, 0.085, bb_line, bd_line, bglow, bcross, g_uv_back);

    vec3 c_back_dark = mix(vec3(0.38, 0.05, 0.45), vec3(0.06, 0.22, 0.48), sin(aspect_uv.y * 4.0 - t) * 0.5 + 0.5);
    vec3 c_back_dim  = c_back_dark * 0.45;
    vec3 back_rgb    = c_back_dark * (bb_line + bglow) + c_back_dim * bd_line;

    // Combined two-layer grid background
    vec3 bg_void = vec3(0.015, 0.005, 0.025);
    vec3 grid_composite = bg_void + back_rgb * 0.65 + front_rgb;

    // =========================================================================
    // CRITICAL REQUIREMENT: THE EFFECT ONLY AFFECTS THE COLOR BLACK
    // =========================================================================
    float max_color = max(tex.r, max(tex.g, tex.b));
    float is_black = 1.0 - smoothstep(0.03, 0.12, max_color);

    // Non-black colors remain 100% original; black areas get the animated dual grid
    vec3 final_rgb = mix(tex.rgb, grid_composite, is_black);

    vec4 final_tex = vec4(final_rgb, tex.a);
    return dissolve_mask(final_tex * colour, texture_coords, uv);
}
#endif
