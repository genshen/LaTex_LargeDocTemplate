# LaTex Large Document Template.
支持大型文档编辑的LaTex模板。
## Features
- 基于中文ctex包的支持中文的LaTex模板(如果不需要中文支持,ctex包可移除)；默认`documentclass`是report, 可以替换为其他，如article，book等(修改document.tex文件即可)；
- title.tex文件为自定义的title，也可以换成简单的`\maketitle`方式；
- 支持按章节生成参考文献;
- 支持全篇编译为pdf, 也支持一章/一节单独编译为pdf, 便于及时查看修改效果；
- 支持Latex文件**多级嵌套**；

注：文档LaTex引言放在*shared/preamble.sty* 文件，各部分公用的包可放在这里面；

## 按章节生成参考文献
模板主要使用`biblatex`包实现在一份文档内独立生成参考文献列表。
例如，如果需要每一章末尾都生成参考文献列表,则需要在每一章的tex文件末尾加上：
```tex
% file: ch1/main.tex
\documentclass[float=false, crop=false]{standalone}
\usepackage{.strange}

\begin{document}
% cite papers.
\printbibliography[heading=subbibliography,title={参考文献}]

\end{document}
```
在`shared/preamble.sty`文件中导入biblatex包需要设置`refsection=chapter`参数。
并且`\addbibresource`中需要将bib文件路径替换成自己本地环境的全局路径。

在项目根目录或者各章目录进行编译测试(例如可以使用`latexmk`编译器进行编译)，检查参考文件列表是否正常。

## 多级嵌套
在顶层文件import各个章节
```tex
\documentclass{report}
\usepackage{.strange}
\begin{document}
...
\chapter{章节一}
\import{ch1/}{main.tex}
...
\end{document}
```
其中`.strange`见后文工具小节。

在各个章节中：
```tex
% file: ch1/main.tex
\documentclass[float=false, crop=false]{standalone}
\usepackage{.strange}

\begin{document}
...
    \subimport{sections/}{section1}  % can also use \input{} or \include{}
\begin{document}
```
```tex
% file: ch1/sections/section1
\documentclass[float=false, crop=false]{standalone}
\usepackage{.strange}

\begin{document}    
    \section{Section1}
    ...
\end{document}
```
上面例子中的三个文件均可单独编译，查看效果。如果你正在编写一小节，可以直接编译该小节的tex文件，快速查看效果(如果要编译顶层文件，可能需要较长时间)。

## .strange
在上述例子中，出现了很多次`\usepackage{.strange}`, 该文件通过**strange**工具生成(工具的实现见strange.go文件)。 `.strange.sty`文件存在于任何有tex文件的目录，用于导入位于*share/preamble.sty*文件，公用的包、环境均写在该*share/preamble.sty*文件中。

用以下的命令问各个目录生成.strange文件。
```bash
cd document/root/dir  # 进入文档项目的根目录
./strange 
```
或者：
```bash
./strange /path/of/document/root/dir
```

## 参考
- https://en.m.wikibooks.org/wiki/LaTeX/Modular_Documents
- https://www.overleaf.com/learn/latex/Management_in_a_large_project
- https://www.overleaf.com/learn/latex/Multi-file_LaTeX_projects
- https://www.overleaf.com/learn/latex/Articles/Getting_started_with_BibLaTeX
