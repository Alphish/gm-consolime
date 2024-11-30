// ------------------
// Drawing background
// ------------------

draw_set_color(bg_color);
draw_set_alpha(bg_alpha);
draw_rectangle(0, 0, terminal_width, terminal_height, false);

var _total_rows = array_length(view.rows);
var _start_index = view.get_reference_index();
var _end_index = min(_start_index + (view.visible_rows - view.input_rows), _total_rows);

// ---------------
// Drawing outputs
// ---------------

draw_set_font(text_font);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

for (var i = _start_index; i < _end_index; i++) {
    var _is_more_rows = (i + 1 >= _end_index && _end_index < _total_rows);
    
    var _row = view.rows[i];
    var _type = _row.output.type;
    
    var _graphics = !_is_more_rows ? (graphics_by_type[$ _type] ?? default_graphics) : more_rows_graphics;
    draw_set_color(_graphics[$ "color"] ?? c_white);
    draw_set_alpha(_graphics[$ "alpha"] ?? 1);
    
    var _xx = padding_left;
    var _yy = padding_top + (i - _start_index) * view_row_height + view_row_height div 2;
    var _content = !_is_more_rows ? _row.content : $"{_total_rows - _end_index + 1} more rows below...";
    draw_text(_xx, _yy, _content);
}

// -------------
// Drawing input
// -------------

var _input_yoffset = (_end_index - _start_index) * view_row_height;
var _input_text = input.get_display_text();
var _input_graphics = graphics_by_type[$ "COMMAND"] ?? default_graphics;
draw_set_color(_input_graphics[$ "color"] ?? c_white);
draw_set_alpha(_input_graphics[$ "alpha"] ?? 1);

for (var i = 0; i < view.input_rows; i++) {
    var _xx = padding_left;
    var _yy = padding_top + _input_yoffset + i * view_row_height + view_row_height div 2;
    var _content = string_copy(_input_text, view.visible_columns * i + 1, view.visible_columns * (i + 1));
    draw_text(_xx, _yy, _content);
}

if (input.blink < input.blink_max div 2) {
    var _row = input.insert_position div view.visible_columns;
    var _column = input.insert_position mod view.visible_columns;
    
    var _xx = padding_left;
    var _yy = padding_top + _input_yoffset + _row * view_row_height + view_row_height div 2;
    var _content = string_repeat(" ", _column) + "_";
    draw_text(_xx, _yy, _content);
}

// -----
// Reset
// -----

draw_set_color(c_white);
draw_set_alpha(1);
