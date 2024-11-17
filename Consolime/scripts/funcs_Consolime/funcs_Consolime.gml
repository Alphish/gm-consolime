function consolime_get() {
    if (!instance_exists(sys_Consolime))
        throw ConsolimeException.instance_not_found();
    
    return sys_Consolime.id;
}

function consolime_get_process(_name) {
    var _key = string_upper(_name);
    var _processes = consolime_get().processes;
    if (!struct_exists(_processes, _key))
        throw ConsolimeException.process_not_found(_key);
    
    return struct_get(_processes, _key);;
}

function consolime_main_process() {
    return consolime_get_process("MAIN");
}

function consolime_clear() {
    consolime_main_process().clear();
}

function consolime_print(_type, _text) {
    var _args = CONSOLIME_ARGS_TO_UNTYPED_ARGS;
    consolime_main_process().print_ext(_type, _text, _args);
}

function consolime_print_ext(_type, _text, _args) {
    consolime_main_process().print_ext(_type, _text, _args);
}

function consolime_print_many(_type) {
    var _lines = CONSOLIME_ARGS_TO_UNTYPED_LINES;
    consolime_main_process().print_many_ext(_type, _lines);
}

function consolime_print_many_ext(_type, _lines) {
    consolime_main_process().print_many_ext(_type, _lines);
}

function consolime_trace(_text) {
    var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
    consolime_main_process().trace_ext(_text, _args);
}

function consolime_trace_ext(_text, _args) {
    consolime_main_process().trace_ext(_text, _args);
}

function consolime_trace_many() {
    var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
    consolime_main_process().trace_many_ext(_lines);
}

function consolime_trace_many_ext(_lines) {
    consolime_main_process().trace_many_ext(_lines);
}

function consolime_info(_text) {
    var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
    consolime_main_process().info_ext(_text, _args);
}

function consolime_info_ext(_text, _args) {
    consolime_main_process().info_ext(_text, _args);
}

function consolime_info_many() {
    var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
    consolime_main_process().info_many_ext(_lines);
}

function consolime_info_many_ext(_lines) {
    consolime_main_process().info_many_ext(_lines);
}

function consolime_success(_text) {
    var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
    consolime_main_process().success_ext(_text, _args);
}

function consolime_success_ext(_text, _args) {
    consolime_main_process().success_ext(_text, _args);
}

function consolime_success_many() {
    var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
    consolime_main_process().success_many_ext(_lines);
}

function consolime_success_many_ext(_lines) {
    consolime_main_process().success_many_ext(_lines);
}

function consolime_warn(_text) {
    var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
    consolime_main_process().warn_ext(_text, _args);
}

function consolime_warn_ext(_text, _args) {
    consolime_main_process().warn_ext(_text, _args);
}

function consolime_warn_many() {
    var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
    consolime_main_process().warn_many_ext(_lines);
}

function consolime_warn_many_ext(_lines) {
    consolime_main_process().warn_many_ext(_lines);
}

function consolime_error(_text) {
    var _args = CONSOLIME_ARGS_TO_TYPED_ARGS;
    consolime_main_process().error_ext(_text, _args);
}

function consolime_error_ext(_text, _args) {
    consolime_main_process().error_ext(_text, _args);
}

function consolime_error_many() {
    var _lines = CONSOLIME_ARGS_TO_TYPED_LINES;
    consolime_main_process().error_many_ext(_lines);
}

function consolime_error_many_ext(_lines) {
    consolime_main_process().error_many_ext(_lines);
}
