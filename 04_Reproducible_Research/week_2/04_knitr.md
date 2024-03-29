knitr
================

-   [Problems, Problems](#problems-problems)
-   [Literate Statistical
    Programming](#literate-statistical-programming)
-   [How Do I Make My Work
    Reproducible?](#how-do-i-make-my-work-reproducible)
-   [Literate Programming: Pros](#literate-programming-pros)
-   [Literate Programming: Cons](#literate-programming-cons)
-   [What is knitr?](#what-is-knitr)
-   [Requirements](#requirements)
-   [What is Markdown?](#what-is-markdown)
-   [What is knitr Good For?](#what-is-knitr-good-for)
-   [What is knitr NOT Good For?](#what-is-knitr-not-good-for)
-   [My First knitr Document](#my-first-knitr-document)
-   [More Complicated Way](#more-complicated-way)
-   [Output](#output)
-   [A Few Notes](#a-few-notes)
-   [Processing of knitr Documents (what happens under the
    hood)](#processing-of-knitr-documents-what-happens-under-the-hood)
-   [Another Example](#another-example)
-   [Hiding Results](#hiding-results)
-   [Inline Text Computations](#inline-text-computations)
-   [Incorporating Graphics](#incorporating-graphics)
-   [Making Tables with xtable](#making-tables-with-xtable)
-   [Setting Global Options](#setting-global-options)
-   [Some common options](#some-common-options)
-   [Caching computations](#caching-computations)
-   [Caching Caveats](#caching-caveats)
-   [Summary](#summary)

> [Slides from this
> lesson](https://github.com/DataScienceSpecialization/courses/raw/master/05_ReproducibleResearch/knitr/knitr.pdf)

## Problems, Problems

-   Authors must undertake considerable effort to put data/results on
    the web
-   Readers must download data/results individually and piece together
    which data go with which code sections, etc.
-   Authors/readers must manually interact with websites  
-   There is no single document to integrate data analysis with textual
    representations; i.e. data, code, and text are not linked.

## Literate Statistical Programming

-   Original idea comes from Don Knuth  
-   An article is a stream of text and code
-   Analysis code is divided into text and code “chunks”  
-   Presentation code formats results (tables, figures, etc.)  
-   Article text explains what is going on  
-   Literate programs are weaved to produce human readable documents and
    tangled to produce machine readable documents
-   Literate programming is a general concept. We need  
    – A documentation language  
    – A programming language  
-   The original Sweave system developed by Friedrich Leisch used LaTeX
    and R  
-   knitr supports a variety of documentation languages

## How Do I Make My Work Reproducible?

-   Decide to do it (ideally from the start)  
-   Keep track of things, perhaps with a version control system to track
    snapshots/changes  
-   Use software whose operation can be coded  
-   Don’t save output  
-   Save data in non-proprietary formats

## Literate Programming: Pros

-   Text and code all in one place, logical order  
-   Data, results automatically updated to reflect external changes
-   Code is live–automatic “regression test” when building a document

## Literate Programming: Cons

-   Text and code all in one place; can make documents difficult to
    read, especially if there is a lot of code  
-   Can substantially slow down processing of documents (although there
    are tools to help)

## What is knitr?

-   An R package written by Yihui Xie (while he was a grad student at
    Iowa State) – Available on CRAN  
-   Supports RMarkdown, LaTeX, and HTML as documentation languages  
-   Can export to PDF, HTML  
-   Built right into RStudio for your convenience

## Requirements

-   A recent version of R  
-   A text editor (the one that comes with RStudio is okay)  
-   Some support packages also available on CRAN  
-   Some knowledge of Markdown, LaTeX, or HTML  
-   We will use Markdown here

## What is Markdown?

-   A simplified version of “markup” languages  
-   No special editor required  
-   Simple, intuitive formatting elements  
-   Complete information available at [Daring
    Fireball](https://daringfireball.net/projects/markdown/basics)

## What is knitr Good For?

-   Manuals  
-   Short/medium-length technical documents  
-   Tutorials
-   Reports (esp. if generated periodically)  
-   Data preprocessing documents/summaries

## What is knitr NOT Good For?

-   Very long research articles  
-   Complex time-consuming computations  
-   Documents that require precise formatting

## My First knitr Document

First create a new document, and then choose an R Markdown document
![First Knitr Document](./images/first-knitr-document.png)

Use markdown for the text, and for code chunks use \`\`\` like separator
![Code Chunk](./images/code-chunk.png)

To process the document clic `knitr HTML` button. ![Process Knitr
Document](./images/process-knitr-document.png)

## More Complicated Way

    library(knitr)
    setwd(<working directory>)
    knit2html(“document.Rmd”)
    browseURL(“document.html”)

## Output

Can be in HTML or others like this document that get a github markdown
document. ![Output](./images/output.png)

![Markdown document](./images/markdown-document.png)

## A Few Notes

-   knitr will fill a new document with filler text; delete it  
-   Code chunks begin with `{r}  and end with`
-   All R code goes in between these markers
-   Code chunks can have names, which is useful when we start making
    graphics

``` r
## R code goes here
```

-   By default, code in a code chunk is echoed, as will the results of
    the computation (if there are results to print)

## Processing of knitr Documents (what happens under the hood)

-   You write the RMarkdown document (.Rmd)  
-   knitr produces a Markdown document (.md)  
-   knitr converts the Markdown document into HTML (by default)  
-   .Rmd -&gt; .md -&gt; .html  
-   You should NOT edit (or save) the .md or .html documents until you
    are finished

## Another Example

For this code in knitr document ![Another
Example](./images/another-example.png)

We get this output. The code is not show, not echoed. ![Output
example](./images/output-example.png)

## Hiding Results

To hide results you have to indicate in chunk like this ![Hide
Results](./images/hide-results.png)

Then you get this ![Output Hide
Results](./images/output-hide-results.png)

## Inline Text Computations

You can make computations in a chunk defining variables to use inline.
Don’t forget to make `echo = FALSE` if you don’t want to show your code.
![Inline Computations](./images/inline-computations.png)

You get this ![Output Inline
Computations](./images/output-inline-computtations.png)

## Incorporating Graphics

You can insert graphics, and define in chunk properties like height.
![Insert Graphic](./images/insert-graphic.png) You get the graphic
inline at document ![Output Insert
Graphic](./images/output-insert-graphic.png)

In behind the scenes, knitr produces this in HTML to insert image
![Knitr in HTML](./images/knitr-in-html.png)

## Making Tables with xtable

With `xtable` you can insert tables in document

First some data

``` r
library(datasets)
data("airquality")
fit <- lm(Ozone ~ Wind + Temp + Solar.R, data = airquality)
```

Second make table and insert inline at document

``` r
library(xtable)
xt <- xtable(summary(fit))
print(xt, type = "html")
```

<!-- html table generated in R 4.1.1 by xtable 1.8-4 package -->
<!-- Wed Dec  8 12:22:44 2021 -->
<table border="1">
<tr>
<th>
</th>
<th>
Estimate
</th>
<th>
Std. Error
</th>
<th>
t value
</th>
<th>
Pr(&gt;\|t\|)
</th>
</tr>
<tr>
<td align="right">
(Intercept)
</td>
<td align="right">
-64.3421
</td>
<td align="right">
23.0547
</td>
<td align="right">
-2.79
</td>
<td align="right">
0.0062
</td>
</tr>
<tr>
<td align="right">
Wind
</td>
<td align="right">
-3.3336
</td>
<td align="right">
0.6544
</td>
<td align="right">
-5.09
</td>
<td align="right">
0.0000
</td>
</tr>
<tr>
<td align="right">
Temp
</td>
<td align="right">
1.6521
</td>
<td align="right">
0.2535
</td>
<td align="right">
6.52
</td>
<td align="right">
0.0000
</td>
</tr>
<tr>
<td align="right">
Solar.R
</td>
<td align="right">
0.0598
</td>
<td align="right">
0.0232
</td>
<td align="right">
2.58
</td>
<td align="right">
0.0112
</td>
</tr>
</table>

## Setting Global Options

-   Sometimes we want to set options for every code chunk that are
    different from the defaults  
-   For example, we may want to suppress all code echoing and results
    output  
-   We have to write some code to set these global options

![Setting global options](./images/setting-global-options.png)

Then the output is ![Output Global
Settings](./images/output-global-settings.png)

## Some common options

-   Output  
    – results: “asis”, “hide”  
    – echo: TRUE, FALSE  
-   Figures  
    – fig.height: numeric – fig.width: numeric

## Caching computations

-   What if one chunk takes a long time to run?  
-   All chunks have to be re-computed every time you re-knit the file  
-   The cache=TRUE op)on can be set on a chunk-bychunk basis to store
    results of computation
-   After the first run, results are loaded from cache

## Caching Caveats

-   If the data or code (or anything external) changes, you need to
    re-run the cached code chunks  
-   Dependencies are not checked explicitly  
-   Chunks with significant side effects may not be cacheable

## Summary

-   Literate statistical programming can be a useful way to put text,
    code, data, output all in one document  
-   knitr is a powerful tool for integrating code and text in a simple
    document format
