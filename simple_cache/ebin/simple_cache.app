{
    application, simple_cache,
    [
        {description, "cache system"},
        {vsn, "0.1.0"},
        {modules, [
            sc_app,
            sc_sup,
            sc_element_sup,
            sc_store,
            sc_element,
            sc_event,
            sc_event_logger
        ]},
        {registered, [sc_sup, sc_element_sup, sc_event]},
        {applicatons, [kernel, sasl, stdlib, mnesia, resource_discovery]},
        {mod, {sc_app, []}}
    ]
}.
