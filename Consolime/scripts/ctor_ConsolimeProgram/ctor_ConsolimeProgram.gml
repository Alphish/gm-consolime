function ConsolimeProgram(_name) constructor {
    name = _name;
    
    static execute = function(_args, _process) {
        throw ConsolimeException.method_not_implemented(self, nameof(process));
    }
}
