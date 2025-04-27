syn match qfLineNr '[^|]*' contained nextgroup=qfSeparator2 contains=qfError,qfWarning,qfInfo,qfHint

syn match qfError 'error' contained
syn match qfWarning 'warning' contained
syn match qfInfo 'info' contained
syn match qfHint 'note' contained

hi! def link qfError DiagnosticError
hi! def link qfWarning DiagnosticWarn
hi! def link qfInfo DiagnosticInfo
hi! def link qfHint DiagnosticHint

hi! def link qfFileName QuickFixFileName
hi! def link qfSeparator1	QuickFixSeparator
hi! def link qfLineNr QuickFixLineNr
hi! def link qfSeparator2	QuickFixSeparator
" hi! def link qfText Normal
