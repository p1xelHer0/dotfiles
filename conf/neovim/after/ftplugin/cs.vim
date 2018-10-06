setlocal omnifunc=OmniSharp#Complete

autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

let g:OmniSharp_selector_ui = 'fzf'
