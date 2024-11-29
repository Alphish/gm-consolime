/// @description Methods definitions

recalculate_view = function() {
    content_width = terminal_width - padding_left - padding_right;
    content_height = terminal_height - padding_top - padding_bottom;
    
    draw_set_font(text_font);
    view_column_width = string_width("M");
    view_row_height = line_height ?? string_height("M");
    
    var _visible_columns = content_width div view_column_width;
    var _visible_rows = content_height div view_row_height;
    view = new ConsolimeTerminalView(process, _visible_columns, _visible_rows);
    view.update();
}
