" Vim filetype plugin file
" Language:	markdown
if exists("b:did_ftplugin_markdown_md2fswiki") | finish | endif
let b:did_ftplugin_markdown_md2fswiki= 1

if !exists('g:md2fswiki_path')
  let g:md2fswiki_path = 'md2fswiki'
endif

command! Md2fswiki call s:md2fswiki(expand("%"))

let s:buf_nr = -1
func! s:md2fswiki (file)
	:execute ':write!'
    if !bufexists(s:buf_nr)
		rightbelow vnew
		file `="[FSWiki]"`
		let s:buf_nr= bufnr('%')
	elseif bufwinnr(s:buf_nr) == -1
		rightbelow vsplit
		execute s:buf_nr. 'buffer'
		delete _
	elseif bufwinnr(s:buf_nr) != bufwinnr('%')
		execute bufwinnr(s:buf_nr) . 'wincmd w'
	endif
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal modifiable
    normal ggdG
	:execute ":0read!" . g:md2fswiki_path . " " . a:file
    normal gg
    setlocal nomodifiable
endf
