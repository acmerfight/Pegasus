{
    application, simple_cache,
    [
        {description, "cache system"},
        {vsn, "0.1.0"},
        {modules, [
            sc_app,
            sc_sup,
        ]},
        {registered, [sc_sup]},
        {applicatons, [kernel, stdlib]},
        {mod, {sc_app, []}}
    ]
}.
