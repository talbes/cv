\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tym-cv}[2020/09/23 tym-cv]

% declare options
% \ProcessOptions\relax

% load base class
\LoadClass[a4paper]{article}

% load packages
\RequirePackage[utf8]{inputenc}
\RequirePackage[scaled]{libertine} %libertine, helvet
% \RequirePackage[T1]{fontenc}
\renewcommand\familydefault{\sfdefault}
\RequirePackage[english]{babel}
\RequirePackage[cm]{fullpage}
\RequirePackage[margin=2.0cm]{geometry}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{parskip}
\RequirePackage{url}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{fontawesome}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{tym-blue}{RGB}{0,101,189}
\definecolor{yacolor}{HTML}{000066}

% custom definitions
% color
\newcommand*{\cvcolor}{yacolor}
% links
\hypersetup{hidelinks,linkcolor=black}
% TODO: distinguish between linkcolor, iconcolor and cvcolor
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

% define picture
\newcommand*{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}

% rendering
\newcommand*\idphoto{
  \tikz\path[fill overzoom image={\@photo},draw]circle[radius=0.5\linewidth];
}
\newcommand\user[2]{\color{\cvcolor}{\Huge\textbf{#1\,#2}}\color{black}}
% \newcommand\user[2]{\color{\cvcolor}{\Huge #1 \textsc{\textbf{#2}}}\color{black}}

\newcommand{\socialinfo}[1]{\def\@socialinfo{#1}}
\newcommand{\socialtext}[2]{\mbox{\textcolor{\cvcolor}{#1}\hspace{0.5em}#2\hspace{1em}}}
\newcommand{\sociallink}[3]{\mbox{\textcolor{\cvcolor}{#1}\hspace{0.5em}\link{#2}{#3}\hspace{1em}}}
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
\titlespacing{\section}{0pt}{5pt}{7pt}
\newcommand\sectionTitle[2]{\section{\texorpdfstring{\color{\cvcolor}#2\enspace {#1}}{#1}}}

% define new title
\makeatletter
\def\@maketitle{
    \begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}
        \user{\@firstname}{\@lastname}\par
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

% define footer
\newcommand*{\makefooter}[3]{%
    \fancyfoot{}
    \fancyfoot[L]{#1}
    \fancyfoot[C]{#2}
    \fancyfoot[R]{#3}
}

\newcommand*{\cvitem}[4][0.0em]{%
    \noindent%
    \begin{tabularx}{\textwidth}{p{#3} X}
        {\textbf{#2:}} & {#4}\\
    \end{tabularx}%
    \par\addvspace{#1}%
}

\newcommand*{\cventry}[5][.05em]{%
    \noindent%
    \begin{tabularx}{\textwidth}{X r}
        {\textbf{#3}} & \hfill\textit{{#2}}\\
        {#4}\\
        \def\temp{#5}\ifx\temp\empty
        %
        \else
        {#5}
        \fi
    \end{tabularx}
    \par%\addvspace{#1}
}

\newenvironment{profile}{
    \par
}{
    \par\vspace{0.5em}
}

% skills environment
\newenvironment{skills}{%
  \renewcommand{\arraystretch}{1.1}

  \begin{tabular}{>{}r>{}p{13cm}} 
}{%
  \end{tabular}
}
\newcommand*\skillsentry[2]{
  \textbf{#1} &   #2\\ 
}