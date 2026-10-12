shader_type canvas_item;
uniform float thick = 2.0; //uniform allows us to shange the parameter in the material

uniform float frequency = 10.0;
uniform float phase_speed = 5.0;
uniform vec4 line_color : source_color = vec4(1,1,1,1);

void fragment() {
    //mask
    vec2 size = TEXTURE_PIXEL_SIZE * thick;
    float outline = 0.0;
    outline += texture(TEXTURE, UV + vec2(-size.x,0)).a; //This line looks at the position of the closest neighbros and checks the transparency
    outline += texture(TEXTURE, UV + vec2(size.x,0)).a;
    outline += texture(TEXTURE, UV + vec2(0,-size.y)).a;
    outline += texture(TEXTURE, UV + vec2(0,size.y)).a;
    
    outline += texture(TEXTURE, UV + vec2(-size.x,size.y)).a; //diagonal pixels, makes it look less ugly
    outline += texture(TEXTURE, UV + vec2(size.x,size.y)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x,-size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x,-size.y)).a;
    
    outline += texture(TEXTURE, UV + vec2(-size.x,size.y*0.5)).a; //Half pixels to also make it look not ugly
    outline += texture(TEXTURE, UV + vec2(size.x,size.y*0.5)).a;
    outline += texture(TEXTURE, UV + vec2(-size.x,-size.y*0.5)).a;
    outline += texture(TEXTURE, UV + vec2(size.x,-size.y*0.5)).a;
    
    outline = step(1, outline);
    float alpha = texture(TEXTURE,UV).a;
    float r = texture(TEXTURE,UV).r;
	float g = texture(TEXTURE,UV).g;
	float b = texture(TEXTURE,UV).b;
	
    if(alpha > 0.5){
        COLOR = vec4(r,g,b,0);
    } else if(outline > 0.5){
		vec2 pos = UV - vec2(0.5);
        float angle = atan(pos.y, pos.x);
		if(angle < 0.0){
			angle += 2.0 * 3.14159265;
		}
		float ring = step(0.0, sin(frequency*angle+TIME*phase_speed));
		COLOR = vec4(line_color.rgb, ring*line_color.a);
    } else {
        COLOR = vec4(0);
    }

}
