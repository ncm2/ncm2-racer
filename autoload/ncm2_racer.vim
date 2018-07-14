if get(s:, 'loaded', 0)
    finish
endif
let s:loaded = 1

let g:ncm2_racer#proc = yarp#py3('ncm2_racer')

let g:ncm2_racer#source = extend(
            \ get(g:, 'ncm2_racer#source', {}), {
            \ 'name': 'racer',
            \ 'priority': 9,
            \ 'mark': 'rs',
            \ 'early_cache': 1,
            \ 'subscope_enable': 1,
            \ 'scope': ['rust'],
            \ 'word_pattern': '[\w/]+',
            \ 'complete_pattern': ['\.', '::'],
            \ 'on_complete': 'ncm2_racer#on_complete',
            \ 'on_warmup': 'ncm2_racer#on_warmup',
            \ }, 'keep')

func! ncm2_racer#init()
    call ncm2#register_source(g:ncm2_racer#source)
endfunc

func! ncm2_racer#on_warmup(ctx)
    call g:ncm2_racer#proc.jobstart()
endfunc

func! ncm2_racer#on_complete(ctx)
    call g:ncm2_racer#proc.try_notify('on_complete',
            \ a:ctx,
            \ getline(1, '$'))
endfunc

func! ncm2_racer#error(msg)
    call g:ncm2_racer#proc.error(a:msg)
endfunc
