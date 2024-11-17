#macro CONSOLIME_ARGS_TO_UNTYPED_ARGS                                   \
    argument_count <= 2 ? undefined : array_create(argument_count - 2); \
    for (var i = 2; i < argument_count; i++) {                          \
        _args[i - 2] = argument[i];                                     \
    }

#macro CONSOLIME_ARGS_TO_TYPED_ARGS             \
    argument_count <= 1 ? undefined : array_create(argument_count - 1); \
    for (var i = 1; i < argument_count; i++) {                          \
        _args[i - 1] = argument[i];                                     \
    }

#macro CONSOLIME_ARGS_TO_UNTYPED_LINES          \
    array_create(argument_count - 1);           \
    for (var i = 1; i < argument_count; i++) {  \
        _lines[i - 1] = argument[i];            \
    }

#macro CONSOLIME_ARGS_TO_TYPED_LINES            \
    array_create(argument_count);               \
    for (var i = 0; i < argument_count; i++) {  \
        _lines[i] = argument[i];                \
    }
