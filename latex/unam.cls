\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{unam}
[2002/06/14 v2.6 thesis class]
\newif\ifphd
\DeclareOption{phd}{\phdtrue}
\DeclareOption{master}{\phdfalse}
\ExecuteOptions{phd}
\newif\ifunamheadings
\newif\ifhalfunamheadings
\newif\ifsmallerheadings
\DeclareOption{latexheadings}{\unamheadingsfalse \halfunamheadingsfalse}
\DeclareOption{unamheadings}{\unamheadingstrue \halfunamheadingsfalse}
\DeclareOption{halfunamheadings}{\halfunamheadingstrue \unamheadingsfalse}
\DeclareOption{normalsizeheadings}{\smallerheadingsfalse}
\DeclareOption{smallerheadings}{\smallerheadingstrue}
\ExecuteOptions{halfunamheadings}
\ExecuteOptions{smallerheadings}
\DeclareOption{10pt}{%
 \iffinal%
  \OptionNotUsed%
  \ClassWarningNoLine{unam}{Font size 10pt not allowed; using 12pt}%
 \else%
  \PassOptionsToClass{10pt}{report}%
 \fi%
}
\DeclareOption{11pt}{%
 \final%
  \OptionNotUsed%
  \ClassWarningNoLine{unam}{Font size 11pt not allowed; using 12pt}%
 \else%
  \PassOptionsToClass{11pt}{report}%
 \fi
}
\newcommand{\prelim@contents}[1]{}
\DeclareOption{tocprelim}{%
  \renewcommand{\prelim@contents}[1]{\addcontentsline{toc}{section}{#1}}
}
\DeclareOption{draft}{%
  \let\ifdraft\iftrue%
  \let\iffinal\iffalse%
  \PassOptionsToClass{final}{report}%
}
\DeclareOption{final}{%
  \let\ifdraft\iffalse%
  \let\iffinal\iftrue%
  \PassOptionsToClass{final}{report}%
}
\DeclareOption{semifinal}{%
  \let\ifdraft\iffalse%
  \let\iffinal\iftrue%
  \PassOptionsToClass{draft}{report}%
}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{report}%
}
\ExecuteOptions{final}
\ProcessOptions

\RequirePackage{multirow}
\RequirePackage{graphicx}
\iffinal\LoadClass[12pt]{report}[1994/06/01]\else\LoadClass{report}[1994/06/01]\fi
\ifunamheadings
  \def\@makechapterhead#1{%
    \begin{center}%
      \MakeUppercase{\@chapapp\space \thechapter} \\
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
  \def\@makeschapterhead#1{%
    \begin{center}%
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
\fi
\ifhalfunamheadings
  \def\@makeschapterhead#1{%
    \begin{center}%
      \MakeUppercase{\bfseries #1}
    \end{center}%
    }
  \ifsmallerheadings
    \def\@makechapterhead#1{%
      {\parindent \z@ \raggedright \normalfont
        \ifnum \c@secnumdepth >\m@ne
            \LARGE\bfseries \@chapapp\space \thechapter
            \par\nobreak
        \fi
        \interlinepenalty\@M
        \LARGE \bfseries #1\par\nobreak
      }}
  \fi
\fi

\ifsmallerheadings
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries}}
\fi

\renewcommand{\footnotesize}{\normalsize}
\renewcommand{\@makefntext}[1]{%
  \parindent 1em%
  \noindent
  \footnotespacing
  \hbox to 1.8em{\hss\@makefnmark}#1
  \par\normalspacing
}
\renewcommand{\defaultscriptratio}{.75}
\renewcommand{\defaultscriptscriptratio}{.6}
\setlength\headsep{25\p@}
\if@twocolumn
\else
  \setlength\topmargin{-0.4in}
  \setlength\headheight{0.16667in}
  \setlength\headsep{0.33333in}
  \setlength\textheight{8.8in}
  \setlength\footskip{0.5in}
  \setlength\oddsidemargin{.6in}
  \setlength\evensidemargin{.6in}
  \setlength\marginparsep{0.1in}
  \setlength\marginparwidth{0.8in}
  \setlength\textwidth{5.80in}
\fi
\if@compatibility
  \setlength\topmargin{0\p@}
\else
\fi
\newcommand{\ps@unam}{%
\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
\def\@oddfoot{}%
\def\@evenhead{\thepage\hfil{\slshape\leftmark}}%
\def\@evenfoot{}%
\def\chaptermark##1{}%
\def\sectionmark##1{}%
}
\newcommand{\ps@unamc}{%
\def\@oddhead{\hfil\thepage\hfil}%
\def\@oddfoot{}%
\def\@evenhead{\@oddhead}%
\def\@evenfoot{}%
\def\chaptermark##1{}%
\def\sectionmark##1{}%
}
\raggedbottom
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\l@figure}{\@dottedtocline{1}{1.5em}{2.6em}}
\let\l@table\l@figure

\newcommand{\@degreefield}{Your Degree}
\newcommand{\degreefield}[1]{\renewcommand{\@degreefield}{#1}}
\newcommand{\@degreeyear}{2007}
\newcommand{\degreeyear}[1]{\renewcommand{\@degreeyear}{#1}}
\newcommand{\@degreeplace}{City, State}
\newcommand{\degreeplace}[1]{\renewcommand{\@degreeplace}{#1}}
\newcommand{\@universityfield}{Your University}
\newcommand{\universityfield}[1]{\renewcommand{\@universityfield}{#1}}
\newcommand{\@universitydept}{Your Department}
\newcommand{\universitydept}[1]{\renewcommand{\@universitydept}{#1}}
\newcommand{\@universitylogo}{logo.png}
\newcommand{\universitylogo}[1]{\renewcommand{\@universitylogo}{#1}}
\newcommand{\@advisor}{Dr. John Doe}
\newcommand{\advisor}[1]{\renewcommand{\@advisor}{#1}}

\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}
        \@mkboth{\uppercase{\bibname}}{\uppercase{\bibname}}%
      \list{\@biblabel{\arabic{enumiv}}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\arabic{enumiv}}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m\relax
      \addcontentsline{toc}{chapter}{\bibname}
      \singlespacing}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \normalspacing
      \endlist}

\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \begin{minipage}[b][10in]{6.5in}
    \renewcommand\arraystretch{1.1}
    \begin{tabular}{cc}
    \multirow{2}{*}{\includegraphics[width=4cm]{\@universitylogo}} & 
     \underline{\large{\underline{\textbf{\textsf{\@universityfield}}}}} \\
     & \textsf{\small{\footnotesize{\@universitydept}}}
    \end{tabular}

    \begin{center}
    \vskip 4cm
    
    \large{``\@title''}
    \vskip 1cm

    \textsf{\textbf{\Large{T\qquad E\qquad S\qquad I\qquad S}}}
    \vskip 1cm

    \textbf{{QUE PARA OBTENER EL GRADO DE:}}
    \vskip 1cm

    \textbf{\uppercase{\@degreefield}}
    \vskip 1.5cm

    \textsf{\textbf{\Large{P\qquad R\qquad E\qquad S\qquad E\qquad N\qquad T\qquad A:}}}
    \vskip 1cm


    \textbf{\large{\uppercase{\@author}}}
    \vskip 1.5cm

    \textbf{\normalsize{DIRECTOR DE TESIS: \@advisor}}
    \end{center}

    \vfill
    \@degreeplace \hfill \@degreeyear.
    \end{minipage}
  \end{titlepage}
}

\renewenvironment{titlepage}{%
  \typeout{Title page}
  \topmargin -0.9in
  \oddsidemargin -0.5in
  \pagestyle{empty}
}{%
  \normalspacing\clearpage
}


\newenvironment{copyrightpage}{%
  \typeout{Copyleft page}
  \pagestyle{empty}
  \null\vfil
  \begin{center}
}{%
  \end{center}
  \vfil\null
  \clearpage%
}

\newcommand{\makecopyright}{%
  \begin{copyrightpage}
  \copyright\ \@copyrightyear{} \@copyrightholder \\
  ALL RIGHTS RESERVED \\[.5in]
  \end{copyrightpage}%
}
\newcommand{\@copyrightholder}{\@author}
\newcommand{\@copyrightyear}{\@degreeyear}

\newcommand{\copyrightholder}[1]{\renewcommand{\@copyrightholder}{#1}}
\newcommand{\copyrightyear}[1]{\renewcommand{\@copyrightyear}{#1}}

\newcommand{\makepublicdomain}{%
  \begin{copyrightpage}
  This document is in the public domain.
  \end{copyrightpage}%
}


\newlength{\@abhdskip}%
\renewenvironment{abstract}{
  \typeout{Abstract}
  \setlength{\@abhdskip}{.6in}
  \addtolength{\@abhdskip}{-\topmargin}
  \addtolength{\@abhdskip}{-\headheight}
  \addtolength{\@abhdskip}{-\headsep}
  \addtolength{\@abhdskip}{-\baselineskip}
  \begin{center}%
    \vspace*{\@abhdskip}%
    \ifphd%
      {\def\\{\noexpand\\} \xdef\@abstracttitle{\@abstracttitle}}
      \expandafter\uppercase\expandafter{\@abstracttitle} \\[0.5\baselineskip]
      \@author,\ Ph.D. \\
      \@universityfield\ \@degreeyear%
    \else
      \normalsize \bfseries\selectfont
      RESUMEN
    \fi%
    \vspace{0.5\baselineskip}%
  \end{center}%
  \pagestyle{empty}
  \thispagestyle{empty}
}{%
%  \clearpage
}

\newcommand{\@abstracttitle}{\@title}
\newcommand{\abstracttitle}[1]{\renewcommand{\@abstracttitle}{#1}}


\newenvironment{dedication}{%
  \prelim@contents{Dedication}
  \null\vfil
  \begin{center}
}{
  \end{center}
  \vfil\null
  \clearpage
}

\newcommand{\singlespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.0}\tiny\CS}
\newcommand{\singlespacingplus}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.25}\tiny\CS}
\newcommand{\doublespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{1.75}\tiny\CS}
\newcommand{\realdoublespacing}{%
  \let\CS=\@currsize\renewcommand{\baselinestretch}{2}\tiny\CS}
\newcommand{\normalspacing}{\doublespacing}
\newcommand{\footnotespacing}{\singlespacing}
\newcommand{\changespacing}[2]{%
  \renewcommand{#1}{%
    \let\CS=\@currsize\renewcommand{\baselinestretch}{#2}\tiny\CS}%
}
\ifdraft\changespacing{\normalspacing}{1}\fi
\newcommand{\changenormalspacing}[1]{\renewcommand{\normalspacing}{#1}}
\normalspacing

\endinput
%%
%% End of file `unam.cls'.
