vim-textobj-postexpr
====================

[![Build Status](https://travis-ci.org/syngan/vim-textobj-postexpr.svg?branch=master)](https://travis-ci.org/syngan/vim-textobj-postexpr)

Required:
- kana/vim-textobj-user
    - https://github.com/kana/vim-textobj-user

mapping:
- `<Plug>(textobj-postexpr-a)`
- `<Plug>(textobj-postexpr-i)`


# Examples

- `omap av <Plug>(textobj-postexpr-a)`
- `omap iv <Plug>(textobj-postexpr-i)`

Let █ be the position of the cursor.

```
tako()
ho█ge[aa[bb](1, 2, 3)]()
(1)foo
```

if do `div` then

```
tako()
█
(1)foo
```

if do `dav` then

```
tako()
█foo
```

When

```
tako()
hoge[a█a[bb](1, 2, 3)]()
(1)foo
```

if do `div` then

```
tako()
hoge[█]()
(1)foo
```

if do `dav` then

```
tako()
hoge[█]()
(1)foo
```


# Blog in Japanese

- [hoge() で囲みたい症候群](http://d.hatena.ne.jp/syngan/20140301/1393676442)
