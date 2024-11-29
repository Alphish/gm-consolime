function ConsolimeException(_code, _description) constructor {
    code = _code;
    description = _description;
}

// -------------------
// Constructor methods
// -------------------

ConsolimeException.instance_not_found = function() {
    return new ConsolimeException(
        $"consolime_instance_not_found",
        $"Cannot use the Consolime functionality without an active Consolime system instance."
        );
}

ConsolimeException.instance_duplicate = function() {
    return new ConsolimeException(
        $"consolime_instance_duplicate",
        $"Cannot create another Consolime system instance. Only one Consolime system instance can exist at once."
        );
}

ConsolimeException.process_not_found = function(_key) {
    return new ConsolimeException(
        $"consolime_process_not_found",
        $"Cannot find a Consolime process with '{_key}' identifier."
        );
}

ConsolimeException.method_not_implemented = function(_caller, _method) {
    return new ConsolimeException(
        $"consolime_method_not_implemented",
        $"{instanceof(_caller)}.{_method} is not implemented."
        );
}
