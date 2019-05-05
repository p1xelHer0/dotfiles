let g:LanguageClient_serverCommands = {
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ }

nnoremap <Leader>2r :!refmt --parse=ml --print=re % > %.re<CR>
nnoremap <Leader>2o :!refmt --parse=re --print=ml % > %.ml<CR>

" opam {{{

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
"let s:opam_share_dir = system("opam config var share")
"let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

"let s:opam_configuration = {}

"function! OpamConfOcpIndent()
"  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
"endfunction
"let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

"function! OpamConfOcpIndex()
"  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
"endfunction
"let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

"function! OpamConfMerlin()
"  let l:dir = s:opam_share_dir . "/merlin/vim"
"  execute "set rtp+=" . l:dir
"endfunction
"let s:opam_configuration['merlin'] = function('OpamConfMerlin')

"let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
"let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
"let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
"for tool in s:opam_packages
"  " Respect package order (merlin should be after ocp-index)
"  if count(s:opam_available_tools, tool) > 0
"    call s:opam_configuration[tool]()
"  endif
"endfor
"" ## end of OPAM user-setup addition for vim / base ## keep this line
"" ## added by OPAM user-setup for vim / ocp-indent ## 51fd572254b762a41dcc2a2454cc87be ## you can edit, but keep this line
"if count(s:opam_available_tools,"ocp-indent") == 0
"  source "/Users/pontusnagy/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
"endif
"" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
"" Append this to your .vimrc to add merlin to vim's runtime-path:
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute 'set rtp+=' . g:opamshare . '/merlin/vim'

"" Also run the following line in vim to index the documentation:
"" :execute "helptags " . g:opamshare . "/merlin/vim/doc"

"" " }}}
"" run the following line in vim to index the documentation:
"" :execute "helptags " . substitute(system('opam config var share'),'\n$','','''') .  "/merlin/vim/doc"
""
