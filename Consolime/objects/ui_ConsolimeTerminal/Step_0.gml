if (keyboard_check_pressed(vk_up) && keyboard_check(vk_shift))
    view.scroll_by(-1);
else if (keyboard_check_pressed(vk_up))
    input.navigate_history(1);

if (keyboard_check_pressed(vk_down) && keyboard_check(vk_shift))
    view.scroll_by(1);
else if (keyboard_check_pressed(vk_down))
    input.navigate_history(-1);

if (keyboard_check_pressed(vk_pageup))
    view.scroll_by(-view.visible_rows);

if (keyboard_check_pressed(vk_pagedown))
    view.scroll_by(view.visible_rows);

if (keyboard_check_pressed(vk_home))
    view.scroll_by(-array_length(view.rows));

if (keyboard_check_pressed(vk_end))
    view.scroll_by(array_length(view.rows));

input.process_input();
view.calculate_input_rows(input.get_display_text());
