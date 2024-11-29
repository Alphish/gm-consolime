function TestConsoleProgram() : ConsolimeProgram("print") constructor {
    static execute = function(_args, _process) {
        array_foreach(_args, method(_process, _process.success));
    }
}
