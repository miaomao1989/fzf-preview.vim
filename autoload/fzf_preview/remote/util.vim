function! fzf_preview#remote#util#project_root() abort
  silent !git rev-parse --show-toplevel
  if v:shell_error
    echomsg 'The current directory is not a git project'
    return ''
  endif

  let git_root = system('git rev-parse --show-toplevel')
  return strpart(git_root, 0, strlen(git_root) - 1)
endfunction

function! fzf_preview#remote#util#is_project_file(file, splited_project_path) abort
  let splited_file_path = split(a:file, '/')
  if len(splited_file_path) == 0
    return 0
  endif

  let is_project_file = 1
  let index = 0
  for dir_name in a:splited_project_path[:len(splited_file_path) - 1]
    if dir_name !=# splited_file_path[index]
      let is_project_file = 0
    endif
    let index = index + 1
  endfor

  return is_project_file
endfunction

function! fzf_preview#remote#util#bufnr_and_lnum_to_lines(bufnr_and_lnum_list, splited_project_path) abort
  let result = []
  for bufnr_and_lnum in a:bufnr_and_lnum_list
    let bufnr = bufnr_and_lnum['bufnr']
    let lnum = bufnr_and_lnum['lnum']
    let bufinfos = getbufinfo(bufnr)

    if len(bufinfos) > 0
      let bufinfo = bufinfos[0]
      let file = bufinfo['name']

      if fzf_preview#remote#util#is_project_file(file, a:splited_project_path) && filereadable(file)
        let file = fnamemodify(file, ':.')
        let line_number = lnum
        let lines = getbufline(bufname(bufnr), lnum)

        if len(lines) > 0
          let text = lines[0]
        else
          let text = ''
        endif

        call add(result, file . ':' . line_number . ' ' . text)
      endif
    endif
  endfor

  return result
endfunction
