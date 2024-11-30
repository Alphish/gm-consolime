function ConsolimeEnvironment() constructor {
    programs_by_name = {};
    
    static register_program = function(_program, _name = undefined) {
        if (is_callable(_program))
            _program = new _program();
        
        _name ??= _program.name;
        
        programs_by_name[$ _name] = _program;
    }
    
    // ---------
    // Execution
    // ---------
    
    static execute_command = function(_process, _command) {
        _process.print("COMMAND", _command);
        _process.record_input(_command);
        
        var _args = parse_command_arguments(_command);
        if (array_length(_args) == 0)
            return;
        
        var _program_name = array_shift(_args);
        var _program = programs_by_name[$ _program_name];
        if (is_undefined(_program)) {
            _process.error($"Unknown program name: '{_program_name}'.");
            return;
        }
        
        try {
            _program.execute(_args, _process);
        } catch (_error) {
            _process.error(_error.longMessage);
        }
    }
    
    static parse_command_arguments = function(_command) {
        var _result = [];
        var _count = string_length(_command);
        var _in_quote = false;
        var _arg_from = 1;
        
        for (var i = 1; i <= _count + 1; i++) {
            var _ch = i <= _count
                ? string_char_at(_command, i)
                : (_in_quote ? "\"" : " ");
            
            if (_ch == "\"") {
                if (!_in_quote && _arg_from < i)
                    continue;
                
                if (!_in_quote) {
                    _in_quote = true;
                    _arg_from = i + 1;
                } else if (i == _count || string_char_at(_command, i + 1) != "\"") {
                    var _quoted = string_copy(_command, _arg_from, i - _arg_from);
                    array_push(_result, string_replace_all(_quoted, "\"\"", "\""));
                    
                    _in_quote = false;
                    _arg_from = i + 1;
                } else {
                    i++;
                }
            }
            
            // handling spaces
            if (!_in_quote && _ch == " ") {
                if (_arg_from < i)
                    array_push(_result, string_copy(_command, _arg_from, i - _arg_from));
                
                _arg_from = i + 1;
            }
        }
        
        return _result;
    }
}
