color ttwnty

nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

augroup insert_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

" autoresize windows on terminal resize
augroup vim_resize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup END

augroup litecorrect
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
augroup END

let g:lexical#thesaurus = ['$HOME/dotfiles/thesaurus/moby.txt',]

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
augroup END

augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

augroup filetype_tsx
  autocmd!
  autocmd FileType typescript set filetype=typescriptreact
augroup END

" repeat last macro if in a Normal buffer
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Show syntax highlighting groups for word under cursor
nmap <F2> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"
lua require("init")
