if (instance_exists(ui_ConsolimeTerminal))
    return;

consolime_get_process("MAIN").execute_command("print lorem ipsum \"dolor sit amet\"");
