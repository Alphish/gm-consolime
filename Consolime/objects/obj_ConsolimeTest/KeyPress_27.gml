if (instance_exists(ui_ConsolimeTerminal))
    instance_destroy(ui_ConsolimeTerminal);
else
    instance_create_layer(x, y, layer, ui_ConsolimeTerminal);
