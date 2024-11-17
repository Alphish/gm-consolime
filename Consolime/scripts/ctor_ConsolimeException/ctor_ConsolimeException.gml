function ConsolimeException(_code, _description) constructor {
    if (!is_instanceof(self, ConsolimeException))
        return; // exiting early for static initialisation
    
    code = _code;
    description = _description;
    
    /// @ignore
    static instance_not_found = function() {
        return new ConsolimeException(
            $"consolime_instance_not_found",
            $"Cannot use the Consolime functionality without an active Consolime system instance."
            );
    }
    
    /// @ignore
    static instance_duplicate = function() {
        return new ConsolimeException(
            $"consolime_instance_duplicate",
            $"Cannot create another Consolime system instance. Only one Consolime system instance can exist at once."
            );
    }
    
    /// @ignore
    static process_not_found = function(_key) {
        return new ConsolimeException(
            $"consolime_process_not_found",
            $"Cannot find a Consolime process with '{_key}' identifier."
            );
    }
}

/// static initialisation
/// feather ignore GM1020
ConsolimeException();
