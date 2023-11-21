nmap <leader>fv <cmd>Ex<cr>
nmap <leader>w <cmd>w<cr>
nmap <leader>h <cmd>noh<cr>
nmap <leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
xmap <silent> <leader>y y<cmd>call system("wl-copy", @")<cr>
nmap <silent> <leader>x <cmd>!chmod +x %<cr>

vmap K :m '<-2<cr>gv=gv
vmap J :m '<+1<cr>gv=gv

" file marks
nmap <leader>1 mA
nmap <leader>2 mB
nmap <leader>3 mC
nmap <leader>4 mD
nmap <leader>5 mE
nmap <leader>6 mF
nmap <leader>7 mG
nmap <leader>8 mH
nmap <leader>9 mI
nmap <leader>0 mJ
nmap <M-1> `A
nmap <M-2> `B
nmap <M-3> `C
nmap <M-4> `D
nmap <M-5> `E
nmap <M-6> `F
nmap <M-7> `G
nmap <M-8> `H
nmap <M-9> `I
nmap <M-0> `J
nmap <leader>dm <cmd>delmarks A-Z<cr>

" window splits
nmap <leader>sv <C-w>v<C-w>l
nmap <leader>sh <C-w>s<C-w>j
nmap <leader>sk <cmd>q<cr>
nmap <leader>sf <cmd>Vex!<cr>
nmap <leader>ve <C-w>=
nmap <leader>vh <C-w>_
nmap <leader>vv <C-w>\|
nmap > 10<C-w>>
nmap < 10<C-w><
nmap <C-.> 10<C-w>+
nmap <C-,> 10<C-w>-
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k
nmap <M-l> <C-w>l

" tabs
nmap <leader>tn <cmd>tabnew<cr>
nmap <leader>tk <cmd>tabclose<cr>
nmap <M-n> <cmd>tabn<cr>
nmap <M-p> <cmd>tabp<cr>

" puts cursor back
nmap J mzJ`z

" keeps cursor center when
" jumping pages
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap <C-f> <C-f>zz
nmap <C-b> <C-b>zz

" keeps cursor center when
" jumping to next search
nmap n nzzzv
nmap N Nzzzv
