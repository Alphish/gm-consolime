function ConsolimeProcess() constructor {
    output_capacity = 1000;
    debug_output_enabled = false;
    debug_filter = undefined;
    
    output = [];
    
    // -----
    // Setup
    // -----
    
    static with_output_capacity = function(_capacity) {
        output_capacity = _capacity;
        var _overflow = array_length(output) - output_capacity;
        if (_overflow > 0)
            array_delete(output, 0, _overflow);
        
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
        array_resize(output, 0);
    }
    
    // Basic printing
    
    static print = function(_type, _text) {
        var _args = CONSOLIME_ARGS_TO_UNTYPED_ARGS;
        print_ext(_type, _text, _args);
    }
    
    static print_ext = function(_type, _text, _args) {
        static newline_sequences = ["\r\n", "\r", "\n"];
        
        _type = string_upper(_type);
        var _resolved_text = is_undefined(_args) || array_length(_args) == 0 ? string(_text) : string_ext(_text, _args);
        var _lines = string_split_ext(_resolved_text, newline_sequences);
        print_many_ext(_type, _lines);
        
        return undefined;
    }
    
    static print_many = function(_type) {
        var _lines = CONSOLIME_ARGS_TO_UNTYPED_LINES;
        print_many_ext(_type, _lines);
    }
    
    static print_many_ext = function(_type, _lines) {
        var _should_debug = debug_output_enabled && (is_undefined(debug_filter) || debug_filter[$ _type] == true);
        var _indent = string_repeat(" ", string_length(_type));
        for (var i = 0, _count = array_length(_lines); i < _count; i++) {
            var _line = _lines[i];
            array_push(output, { type: _type, text: _line, line: i });
            
            if (_should_debug)
                show_debug_message(i == 0 ? $"{_type}: {_line}" : $"{_indent}  {_line}");
        }
        
        var _overflow = array_length(output) - output_capacity;
        if (_overflow > 0)
            array_delete(output, 0, _overflow);
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
