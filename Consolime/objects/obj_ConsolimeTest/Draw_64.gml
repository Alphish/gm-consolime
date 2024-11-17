var _process = consolime_main_process();
for (var i = 0; i < array_length(_process.output); i++) {
    var _line = _process.output[i];
    draw_text(x, y + 20 * i, string(_line.line) + " " + _line.type);
    draw_text(x + 120, y + 20 * i, _line.text);
}
