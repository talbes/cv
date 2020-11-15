\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tym-cv}[2020/09/23 tym-cv]

% load base class
\LoadClass[a4paper,11pt]{article}

% declare options
% todo class options: icons on/off, font lmodern/libertine and sf/rm, coloroptions, fontsize
% \DeclareOption{icons}{\def\icons{true}}
% \ProcessOptions\relax

% load packages
\RequirePackage[utf8]{inputenc}
% fonts: libertine or lmodern
\RequirePackage{libertine}
\renewcommand\familydefault{\sfdefault}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\RequirePackage[cm]{fullpage}
\RequirePackage[margin=2.0cm]{geometry}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{parskip}
\RequirePackage{url}
\RequirePackage{tikz}
\RequirePackage{expl3}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{fontawesome}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\definecolor{tym-blue}{RGB}{0,101,189}
\definecolor{yacolor}{HTML}{000066}

% custom definitions
% color
% distinguish between cvcolor (name) iconcolor, section headings color and letter color
\newcommand*{\cvcolor}{yacolor}
\newcommand*{\cvicon}{\cvcolor}
\newcommand*{\cvheading}{\cvcolor}
\newcommand*{\cvltr}{\cvcolor}
% links
\hypersetup{hidelinks,linkcolor=black}
% fancyhdr
\fancyhf{}
\fancyhfoffset{0em}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}
\fancypagestyle{plain}{\pagestyle{fancy}}

% define firstname, lastname and name
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}

% define jobtitle
\newcommand*{\mtitle}[1]{\def\@mtitle{#1}}

%% letter %%
\newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientfirm{#2}}
\newcommand*{\sender}[2]{\def\@sendername{#1}
\def\@senderinfo{#2}}
\newcommand*{\when}[1]{\def\@when{#1}}
\newcommand*{\subject}[1]{\def\@subject{#1}}
\newcommand*{\opening}[1]{\def\@opening{#1}}
\newcommand*{\closing}[1]{\def\@closing{#1}}
\newcommand*{\enclosing}[1]{\def\@enclosing{#1}}

% define picture
\newcommand*{\photo}[5]{\def\@photo{#1}\def\@photodiameter{#2}\def\@yshift{#3}\def\@zoom{#4}\def\@picolor{#5}}

% rendering
\newcommand*\idphoto{
\begin{tikzpicture}
    \clip (0,0) circle (\@zoom\linewidth);
    \node[anchor=center] at (0,\@yshift) { \includegraphics[width=\@photodiameter]{\@photo} };
    \draw[\@picolor,ultra thick] (0,0) circle (\@zoom\linewidth);
\end{tikzpicture}
}

\newcommand\user[2]{#1 #2}

\newcommand{\socialinfo}[1]{\def\@socialinfo{#1}}
\newcommand{\socialtext}[2]{\mbox{\color{\cvicon}{#1}\color{black}\hspace{0.5em}#2\hspace{1em}}}
\newcommand{\sociallink}[3]{\mbox{\color{\cvicon}{#1}\color{black}\hspace{0.5em}\link{#2}{#3}\hspace{1em}}}
\newcommand\link[2]{\href{#1}{#2}}

% social items
\newcommand*{\address}[1]{\socialtext{\faMapMarker}{#1}}
\newcommand*{\infos}[1]{\socialtext{\faInfo}{#1}}
\newcommand*{\linkedin}[1]{\sociallink{\faLinkedin}{http://www.linkedin.com/in/#1/fr}{linkedin.com/in/#1}}
\newcommand*{\github}[1]{\sociallink{\faGithub}{https://www.github.com/#1}{github.com/#1}}    
\newcommand*{\email}[1]{\sociallink{\faAt}{mailto:#1}{#1}}
\newcommand*{\website}[2]{\sociallink{\faGlobe}{#1}{#2}}
\newcommand*{\smartphone}[1]{\socialtext{\faMobilePhone}{#1}}    

% setup section headers via titlesec
\titleformat{\section}{\Large\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{6pt}{9pt}
\newcommand\sectionTitle[2]{\section{\texorpdfstring{\color{\cvheading}#2\enspace\textbf{#1}}{#1}}}

% define new title
\makeatletter
\def\@maketitle{
    \begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}
        {\color{\cvcolor}\Huge\bfseries\user{\@firstname}{\@lastname}\color{black}\par}
        \large{\@mtitle}\par
        \bigskip
        \small{\@socialinfo}
    \end{minipage}
    \begin{minipage}{\@photodiameter}
        \idphoto
    \end{minipage}
    \bigskip
}
\makeatother

% define letter macros
\makeatletter
\newcommand*\mkltrhead{
    \clearpage
    \thispagestyle{empty}
    % either both \centering or \raggedleft+\raggedright 
    % or \raggedright+\raggedleft
    {\raggedright\color{\cvltr}\LARGE\textbf{\user{\@firstname}{\@lastname}}\\\vspace{-0.4em}}
    \noindent\hrulefill\\
    {\raggedleft\@senderinfo\par}
    \vspace{2.5cm}
    {\raggedright
    \@recipientfirm\\
    \@recipientname
    \par}
    \vspace{1cm}
    {\raggedleft\@when\par}
    \vspace{0.5cm}
    {\bfseries\@subject\par}
    \vspace{1.0cm}
    {\@opening\par}
}
\newcommand*\mkltrfoot{
    \vspace{2cm}
    {\@closing\par}
    \vspace{1.5cm}
    {\user{\@firstname}{\@lastname}\par}
    \vspace{1cm}
    {\itshape\sffamily\textcolor{gray}{\@enclosing}}
}
\makeatother

% remove reference numbers
\makeatletter
\renewcommand\@biblabel[1]{}
\makeatother

% define footer
\newcommand*{\makefooter}[3]{%
    \fancyfoot{}
    \fancyfoot[L]{#1}
    \fancyfoot[C]{#2}
    \fancyfoot[R]{#3}
}

\newcommand*{\cvitem}[4][-0.2em]{%
    \noindent%
    \begin{tabularx}{\textwidth}{p{#3} X}
        {\textbf{#2:}} & {#4}\\
    \end{tabularx}%
    \par\addvspace{#1}%
}

\newcommand*{\cventry}[5][-0.25em]{%
    \noindent%
    \begin{tabularx}{\textwidth}{X p{3.3cm}}
        {\textbf{#3}} & \hfill{\textit{#2}}\\
        {#4}\\
        \def\temp{#5}\ifx\temp\empty
        %
        \else
        {#5}
        \fi
    \end{tabularx}
    \par\addvspace{#1}
}

\newcommand*{\cvproject}[4][.0em]{%
    \noindent%
    \begin{tabularx}{\textwidth}{X}
        {\textbf{#2}}\\
        {#3}\\
        \def\temp{#4}\ifx\temp\empty
        %
        \else
        {#4}
        \fi
    \end{tabularx}
    \par\addvspace{#1}
}

\newenvironment{profile}{
    \par
}{
    \par\vspace{0.5em}
}