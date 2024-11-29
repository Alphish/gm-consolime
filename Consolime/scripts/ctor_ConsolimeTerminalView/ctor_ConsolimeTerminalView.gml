function ConsolimeTerminalView(_process, _visible_columns, _visible_rows) constructor {
    process = _process;
    visible_columns = _visible_columns;
    visible_rows = _visible_rows;
    
    oid_from = 0;
    oid_to = 0;
    rows = [];
    
    reference_row = undefined;
    
    static update = function() {
        var _process_oid_from = array_length(process.outputs) > 0 ? array_first(process.outputs).oid : process.next_oid;
        var _process_oid_to = process.next_oid;
        
        if (_process_oid_from == oid_from && _process_oid_to == oid_to)
            return;
        
        if (_process_oid_from == _process_oid_to) {
            array_resize(rows, 0);
            oid_from = _process_oid_from;
            oid_to = _process_oid_to;
            return;
        }
        
        // delete stale rows
        for (var i = 0; i < array_length(rows); i++) {
            var _oid = rows[i].output.oid;
            if (_oid < _process_oid_from) {
                if (i >= array_length(rows) - 1)
                    array_resize(rows, 0);
                
                continue;
            }
            
            if (i != 0)
                array_delete(rows, 0, i);
            
            break;
        }
        
        // add new rows
        var _new_count = _process_oid_to - oid_to;
        for (var i = array_length(process.outputs) - _new_count; i < array_length(process.outputs); i++) {
            var _output = process.outputs[i];
            add_output_rows(_output);
        }
        
        oid_from = _process_oid_from;
        oid_to = _process_oid_to;
        
        if (!is_undefined(reference_row) && reference_row.output.oid < oid_from) {
            reference_row = array_first(rows);
        }
    }
    
    static add_output_rows = function(_output) {
        var _row_count = string_length(_output.text) div visible_columns;
        for (var i = 0; i <= _row_count; i++) {
            var _row_content = string_copy(_output.text, i * visible_columns + 1, visible_columns);
            array_push(rows, new ConsolimeTerminalRow(_output, _row_content, i));
        }
    }
    
    static get_reference_index = function() {
        if (is_undefined(reference_row))
            return max(array_length(rows) - visible_rows, 0);
        else
            return array_get_index(rows, reference_row);
    }
    
    static scroll_by = function(_rows) {
        var _min_index = 0;
        var _max_index = max(array_length(rows) - visible_rows, 0);
        var _current_index = get_reference_index();
        var _target_index = clamp(_current_index + _rows, _min_index, _max_index);
        reference_row = _target_index == _max_index ? undefined : rows[_target_index];
    }
}
