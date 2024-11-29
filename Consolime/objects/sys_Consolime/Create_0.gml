if (instance_number(sys_Consolime) > 1)
    throw ConsolimeException.instance_duplicate();

processes = {};

if (!is_undefined(main_environment)) {
    var _environment = is_callable(main_environment) ? new main_environment() : main_environment;
    
    var _process = new ConsolimeProcess(_environment);
    _process.with_output_capacity(main_output_capacity);
    if (main_debug_output_enabled)
        _process.with_debug_output(main_debug_filter);
    else
        _process.with_no_debug_output();
    
    processes[$ "MAIN"] = _process;
}
