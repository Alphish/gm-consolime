process = consolime_get_process(process_name);

terminal_width = display_get_gui_width();
terminal_height = display_get_gui_height();

padding_top ??= padding_left;
padding_right ??= padding_left;
padding_bottom ??= padding_top;

default_graphics = { color: c_white };
graphics_by_type = {
    COMMAND: { color: c_white },
    TRACE: { color: c_gray },
    INFO: { color: #0080FF },
    SUCCESS: { color: #40C040 },
    WARNING: { color: #FFC000 },
    ERROR: { color: #FF4000 },
};
more_rows_graphics = { color: c_gray };

view_column_width = undefined;
view_row_height = undefined;
view = undefined;

event_user(0);

recalculate_view();
