# LaTex Large Document Template.
支持大型文档编辑的LaTex模板。
## Features
- 基于中文ctex包的支持中文的LaTex模板(如果不需要中文支持,ctex包可移除)；
- 支持全篇编译为pdf, 也支持**一章/一节单独编译为pdf**, 便于及时查看修改效果；
- 支持Latex文件**多级嵌套**。

## 说明
1. 默认`documentclass`是report, 可以替换为其他，如article，book等(修改document.tex文件即可)；
2. 文档LaTex引言放在*preamble.sty* 文件，各部分公用的包可以放在这里面；
3. title.tex文件为自定义的title，也可以换成简单的`\maketitle`方式；
4. 多级嵌套：
    ```tex
    % parent.tex
    \import{%%dir of sub_file.tex%%}{sub_file.tex} % import sub_file.tex
    ```

    ```tex
    % sub_file.tex
    \documentclass[float=false, crop=false]{standalone}
    \IfStandalone{ \usepackage{%%relative path of preamble.sty%%} }{ \usepackage{preamble} }
    \begin{document}
    % write you ducument here.
    \import{%%dir of other_sub_file.tex%%}{other_sub_file.tex}
    \end{document}
    ```
    注意：嵌套的子tex文件不支持`\chapter`章节, `\chapter`的标记需要放在最顶层的tex文件中(见document.tex文件)。

## 参考
- https://en.m.wikibooks.org/wiki/LaTeX/Modular_Documents
- https://www.overleaf.com/learn/latex/Management_in_a_large_project
- https://www.overleaf.com/learn/latex/Multi-file_LaTeX_projects
