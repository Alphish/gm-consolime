function ConsolimeTerminalInput(_terminal) constructor {
    terminal = _terminal;
    process = terminal.process;
    
    text = "";
    insert_position = 0;
    keyboard_string = ""; // clean up the keyboard_string from earlier
    max_length = 256;
    history_index = 0;
    
    // handling the underscore "blinking" at the current input position
    blink = 0;
    blink_max = 40;
    
    // handling repeated inputs by holding down specific keys
    // so if you hold down a key long enough, it's as if you press it repeatedly
    // it mirrors similar repetition for letters/digits/etc.
    // as hanled by keyboard_string
    
    repeatable_keys = [vk_left, vk_right, vk_backspace, vk_delete];
    repeatable_count = array_length(repeatable_keys);
    
    repeat_key = undefined;
    repeat_time = 0;
    repeat_delay = 15; // the number of frames after which repetition should be detected
    repeat_period = 3; // the number of frames between subsequent input repetitions
    
    static process_input = function() {
        // increasing the blink underscore timer
        blink++;
        blink = blink mod blink_max;
        
        // handling newly added characters with keyboard_string
        if (keyboard_string != "") {
            // going through each accumulated character and adding it to the input text
            string_foreach(keyboard_string, function(_character) {
                // for my intents and purposes, I decided to omit non-ASCII characters
                // if you want to support non-ASCII characters, you may remove this condition
                if (ord(_character) >= 128)
                    return;
                
                // don't add any new characters if the input string is already long enough
                if (string_length(text) == max_length)
                    return;
                
                // append the character to the text
                if (insert_position < string_length(text))
                    text = string_insert(_character, text, insert_position + 1);
                else
                    text += _character;
                
                insert_position++;
            });
            
            // with all new characters handled, clear the accumulated text
            keyboard_string = "";
        }
        
        // updating the state of repeatable keys
        check_repeats();
        
        // moving the cursor
        if (is_repeated(vk_left))
            insert_position--;
        else if (is_repeated(vk_right))
            insert_position++;
        
        insert_position = clamp(insert_position, 0, string_length(text));
        
        // deleting characters via backspace and delete
        if (is_repeated(vk_backspace) && insert_position > 0) {
            text = string_delete(text, insert_position, 1);
            insert_position--;
        }
        
        if (is_repeated(vk_delete) && insert_position < string_length(text)) {
            text = string_delete(text, insert_position + 1, 1);
        }
        
        if (keyboard_check_pressed(vk_enter)) {
            process.execute_command(text);
            terminal.view.reference_row = undefined;
            text = "";
            history_index = 0;
        }
    }
    
    // updates the state of the repeated inputs
    static check_repeats = function() {
        // if any new repeated input key is pressed
        // it becomes the new repetition target
        for (var i = 0; i < repeatable_count; i++) {
            if (keyboard_check_pressed(repeatable_keys[i])) {
                repeat_key = repeatable_keys[i];
                repeat_time = 0;
                return;
            }
        }
        
        if (is_undefined(repeat_key))
            return;
        
        if (keyboard_check(repeat_key)) {
            // keep increasing the repeat timer while holding down the key
            repeat_time++;
        } else {
            // while the key is no longer held down, stop the repetition
            repeat_key = undefined;
            repeat_time = 0;
        }
    }
    
    // checks whether an input repetition is made for the given key
    // in the current frame
    static is_repeated = function(_key) {
        if (repeat_key != _key)
            return false; // the key isn't a target of repetition
        else if (repeat_time == 0)
            return true; // the key has just been pressed
        else if (repeat_time < repeat_delay)
            return false; // waiting for start of repetition
        else
            return (repeat_time - repeat_delay) mod repeat_period == 0; // performing repetition every X frames
    }
    
    static get_display_text = function() {
        if (string_length(text) >= max_length)
            return text;
        else
            return text + " ";
    }
    
    static navigate_history = function(_direction) {
        var _index = history_index + _direction;
        var _input = process.get_historical_input(_index);
        if (is_undefined(_input))
            return;
        
        text = _input;
        insert_position = string_length(text);
        history_index = _index;
    }
}