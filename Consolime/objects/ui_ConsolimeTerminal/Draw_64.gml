draw_set_color(bg_color);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, terminal_width, terminal_height, false);

var _start_index = view.get_reference_index();
var _end_index = min(_start_index + view.visible_rows, array_length(view.rows));

for (var i = _start_index; i < _end_index; i++) {
    var _row = view.rows[i];
    var _type = _row.output.type;
    var _graphics = graphics_by_type[$ _type] ?? default_graphics;
    draw_set_color(_graphics[$ "color"] ?? c_white);
    draw_set_alpha(_graphics[$ "alpha"] ?? 1);
    draw_set_font(text_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    var _xx = padding_left;
    var _yy = padding_top + (i - _start_index) * view_row_height + view_row_height div 2;
    draw_text(_xx, _yy, _row.content);
}

draw_set_color(c_white);
draw_set_alpha(1);
