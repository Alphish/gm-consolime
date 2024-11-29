function ConsolimeProcess() constructor {
    output_capacity = 1000;
    debug_output_enabled = false;
    debug_filter = undefined;
    
    outputs = [];
    next_oid = 0;
    
    // -----
    // Setup
    // -----
    
    static with_output_capacity = function(_capacity) {
        output_capacity = _capacity;
        var _overflow = array_length(outputs) - output_capacity;
        if (_overflow > 0)
            array_delete(outputs, 0, _overflow);
        
        return self;
    }
    
    static with_debug_output = function(_filter = undefined) {
        debug_output_enabled = true;
        
        if (is_array(_filter)) {
            debug_filter = {};
            var _filter_setter = method(debug_filter, function(_item) { self[$ string_upper(_item)] = true; });
            array_foreach(_filter, _filter_setter);
        } else {
            debug_filter = _filter;
        }
        
        return self;
    }
    
    static with_no_debug_output = function() {
        debug_output_enabled = false;
        debug_filter = undefined;
        return self;
    }
    
    // --------------
    // Output methods
    // --------------
    
    // Clearing
    
    static clear = function() {
        array_resize(outputs, 0);
    }
    
    // Basic printing
    
    static print = function(_type, _text) {
        var _args = CONSOLIME_ARGS_TO_UNTYPED_ARGS;
        print_ext(_type, _text, _args);
    }
    
    static print_ext = function(_type, _text, _args) {
        static text_lines = [""];
        
        _type = string_upper(_type);
        text_lines[0] = is_undefined(_args) || array_length(_args) == 0 ? string(_text) : string_ext(_text, _args);
        print_many_ext(_type, text_lines);
        
        return undefined;
    }
    
    static print_many = function(_type) {
        var _lines = CONSOLIME_ARGS_TO_UNTYPED_LINES;
        print_many_ext(_type, _lines);
    }
    
    static print_many_ext = function(_type, _lines) {
        _lines = flatten_lines(_lines);
        
        var _should_debug = debug_output_enabled && (is_undefined(debug_filter) || debug_filter[$ _type] == true);
        var _indent = string_repeat(" ", string_length(_type));
        for (var i = 0, _count = array_length(_lines); i < _count; i++) {
            var _line = _lines[i];
            array_push(outputs, new ConsolimeOutput(_type, _line, i, next_oid++));
            
            if (_should_debug)
                show_debug_message(i == 0 ? $"{_type}: {_line}" : $"{_indent}  {_line}");
        }
        
        var _overflow = array_length(outputs) - output_capacity;
        if (_overflow > 0)
            array_delete(outputs, 0, _overflow);
    }
    
    static flatten_lines = function(_lines) {
        static newline_sequences = ["\r\n", "\r", "\n"];
        static result = [];
        
        array_resize(result, 0);
        for (var i = 0; i < array_length(_lines); i++) {
            var _line = string_trim_end(_lines[i], newline_sequences);
            if (string_pos("\r", _line) == 0 && string_pos("\n", _line) == 0) {
                array_push(result, _line);
                continue;
            }
            
            var _split = string_split_ext(_line, newline_sequences);
            for (var j = 0; j < array_length(_split); j++) {
                array_push(result, _split[j]);
            }
        }
        return result;
    }
    
    // Tracing
    
    static trace = function(_text) {
        var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
        trace_ext(_text, _args);
    }
    
    static trace_ext = function(_text, _args) {
        return print_ext("TRACE", _text, _args);
    }
    
    static trace_many = function() {
        var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
        trace_many_ext(_lines);
    }
    
    static trace_many_ext = function(_lines) {
        print_many_ext("TRACE", _lines);
    }
    
    // Info
    
    static info = function(_text) {
        var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
        info_ext(_text, _args);
    }
    
    static info_ext = function(_text, _args) {
        return print_ext("INFO", _text, _args);
    }
    
    static info_many = function() {
        var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
        info_many_ext(_lines);
    }
    
    static info_many_ext = function(_lines) {
        print_many_ext("INFO", _lines);
    }
    
    // Success
    
    static success = function(_text) {
        var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
        success_ext(_text, _args);
    }
    
    static success_ext = function(_text, _args) {
        return print_ext("SUCCESS", _text, _args);
    }
    
    static success_many = function() {
        var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
        success_many_ext(_lines);
    }
    
    static success_many_ext = function(_lines) {
        print_many_ext("SUCCESS", _lines);
    }
    
    // Warnings
    
    static warn = function(_text) {
        var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
        warn_ext(_text, _args);
    }
    
    static warn_ext = function(_text, _args) {
        return print_ext("WARNING", _text, _args);
    }
    
    static warn_many = function() {
        var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
        warn_many_ext(_lines);
    }
    
    static warn_many_ext = function(_lines) {
        print_many_ext("WARNING", _lines);
    }
    
    // Errors
    
    static error = function(_text) {
        var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
        error_ext(_text, _args);
    }
    
    static error_ext = function(_text, _args) {
        return print_ext("ERROR", _text, _args);
    }
    
    static error_many = function() {
        var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
        error_many_ext(_lines);
    }
    
    static error_many_ext = function(_lines) {
        print_many_ext("ERROR", _lines);
    }
}
