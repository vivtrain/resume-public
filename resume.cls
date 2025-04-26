% Class Declaration
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[Custom resume template, designed by Vivek Kumar]

% Base class
\LoadClass[10pt,letterpaper]{article}

% Packages
\RequirePackage[letterpaper, margin=0.5in]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{keyval}
\RequirePackage[headings]{fancyhdr}
  \setlength{\headheight}{1in}
  \setlength{\headsep}{-0.125in}
  \renewcommand{\headrulewidth}{0pt}
\RequirePackage{hyperref}
  \hypersetup{colorlinks=true, urlcolor=black}
  \urlstyle{same}
\RequirePackage{fontawesome5}
\RequirePackage{phonenumbers}
\RequirePackage{titlesec}
  \titleformat{\section}[display]{\DisplayFont{size=\LARGE, shape=\scshape}}{}{0pt}{}
  \titlespacing{\section}{0pt}{-16pt}{4pt}
\RequirePackage[skip=0pt, indent=0pt]{parskip}
\RequirePackage{xcolor}
\RequirePackage{changepage}
\RequirePackage{graphics}

% Fonts
\RequirePackage{montserrat}
\RequirePackage[scale=0.9]{opensans}
\def\DisplayFamily{\fontfamily{Montserrat-LF}\selectfont}
\def\BodyFamily{\fontfamily{opensans-TLF}\selectfont}
% Font macros
\define@key{DisplayFontKeys}{series}{\def\series{#1}}
\define@key{DisplayFontKeys}{size}{\def\size{#1}}
\define@key{DisplayFontKeys}{shape}{\def\shape{#1}}
\newcommand{\DisplayFont}[1]{%
  \def\series{m}%
  \def\size{\normalsize}%
  \def\shape{\normalshape}%
  \setkeys{DisplayFontKeys}{#1}%
  \DisplayFamily\fontseries{\series}\selectfont\size\shape%
}
\define@key{BodyFontKeys}{series}{\def\series{#1}}
\define@key{BodyFontKeys}{size}{\def\size{#1}}
\define@key{BodyFontKeys}{shape}{\def\shape{#1}}
\newcommand{\BodyFont}[1]{%
  \def\series{m}%
  \def\size{\normalsize}%
  \def\shape{\normalshape}%
  \setkeys{BodyFontKeys}{#1}%
  \BodyFamily\fontseries{\series}\selectfont\size\shape%
}

% Change bullet character
\renewcommand{\labelitemi}{\boldmath$\cdot$}

% Title of the resume, usually the candidate's name, placed in the header
\newcommand{\ResumeTitle}[1]{
  \pagestyle{fancy}
  \fancyhead[L]{\resizebox{!}{20pt}{\DisplayFont{size=\Huge, shape=\scshape}#1}\vspace{4pt}}
  \hypersetup{pdftitle={#1 -- Resume}, pdfauthor={#1}}
  \title{#1 -- Resume}
  \author{#1}
}

% Contact info group, pass this key=value pairs to add them to the header
\define@key{ContactInfoKeys}{email}{\def\email{#1}}
\define@key{ContactInfoKeys}{phone}{\def\phone{#1}}
\define@key{ContactInfoKeys}{linkedin}{\def\linkedin{#1}}
\define@key{ContactInfoKeys}{website}{\def\website{#1}}
\define@key{ContactInfoKeys}{github}{\def\github{#1}}
\newcommand{\ContactInfo}[1]{
  \setkeys{ContactInfoKeys}{#1}
  \pagestyle{fancy}
  \fancyhead[R]{
    \parbox{0.4\textwidth}{
      \raggedleft\BodyFont{series=m}
      \ifundef{\email}{}{%
        \faIcon{envelope}\nobreak\enskip\href{mailto:\email}{\email}}\quad%
      \ifundef{\phone}{}{%
        \small\faIcon{phone-alt}\nobreak\enskip%
        \phonenumber[country=US, area-code-sep=brackets]{\phone}}\quad%
      \ifundef{\website}{}{%
        \faIcon{globe-americas}\nobreak\enskip\url{http://\website}}\quad%
      \ifundef{\linkedin}{}{%
        \faIcon{linkedin}\nobreak\enskip%
        \href{http://linkedin.com/in/\linkedin}{\linkedin}}\quad%
      \ifundef{\github}{}{%
        \faIcon{github}\nobreak\enskip%
        \href{http://github.com/\github}{\github}}\quad%
    }
    \vspace{6pt}
  }
}

% Delineate sections with an hrule and minimal space, option for horizontal kerning
\newcommand{\ResumeSection}[2][0pt]{
  \vspace{8pt}%
  {\color{black!25}\hrule}
  \section{\hspace{#1}#2}
}

% Push content over a bit for organization purposes
\newenvironment{IndentedBlock}[1][0.125in]{\begin{adjustwidth}{#1}{}}{\end{adjustwidth}}

% Education line item
\newcommand{\EducationItem}[1]{{\,\small\faIcon{graduation-cap}}{\DisplayFont{}\ #1}}

% Skills bullet list
\newenvironment{SkillsBlock}[2][0pt]
{
  \hspace{#1}{\DisplayFont{series=m, shape=\scshape}#2}
  \vspace{2pt}
  \BodyFont{series=l, size=\small}
  \begin{IndentedBlock}[-0.125in]
    \begin{itemize}\setlength{\itemsep}{0pt}
}
{
    \end{itemize}
  \end{IndentedBlock}
}

% Experience bullet list, with option for space after block
\define@key{ExperienceBlockKeys}{experience}{\def\experience{#1}}
\define@key{ExperienceBlockKeys}{role}{\def\role{#1}}
\define@key{ExperienceBlockKeys}{year}{\def\year{#1}}
\define@key{ExperienceKernKeys}{left}{\def\kernLeft{#1}}
\define@key{ExperienceKernKeys}{after}{\def\kernAfter{#1}}
\newenvironment{ExperienceBlock}[2][]
{
  \def\experience{Experience}
  \def\year{20XX}
  \def\kernLeft{0pt}
  \def\kernAfter{8pt}
  \setkeys{ExperienceBlockKeys}{#2}%
  \setkeys{ExperienceKernKeys}{#1}%
  \DisplayFont{series=m, size=\large} \hspace{\kernLeft}\experience%
  \ifdef{\role}{\DisplayFont{series=l, shape=\slshape}\enskip--\enskip\role}{\unskip}
  \DisplayFont{series=m, size=\small, shape=\normalshape}\hfill \year \hbox{\hspace{0.125in}}
  \vspace{2pt}
    \begin{IndentedBlock}[-6pt]
      \begin{itemize}\BodyFont{series=l, size=\normalsize}\setlength{\itemsep}{0pt}
}
{
      \end{itemize}
    \end{IndentedBlock}
  \vspace{\kernAfter}
}

% Convenient tilde for textual approximation
\def\approxTilde{{\fontfamily{\rmdefault}\fontseries{m}\selectfont\raisebox{0.5ex}{\texttildelow}}}
