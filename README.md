svmtutorial
===========

Source of [svm-tutorial.com](https://www.svm-tutorial.com/), the Support Vector Machine tutorials by Alexandre Kowalczyk.

## Layout

- `website/`: the blog, a [Hugo](https://gohugo.io/) site using the [Hugo Book](https://github.com/alex-shpak/hugo-book) theme. Articles are Markdown files in `website/content/articles/`; math is written in LaTeX between `$...$` or `$$...$$` and rendered with KaTeX at build time.
- `code-samples/`: code that goes with the articles (C# text classifier, text classification and support vector regression in R).

## Writing and previewing

Install [Hugo extended](https://gohugo.io/installation/) and Go, then:

```
cd website
hugo server
```

and open http://localhost:1313/.

Each article keeps its original WordPress address through the `url` field in its front matter, for example `url: "/2014/11/svm-understanding-math-part-1/"`. Images live in `website/static/wp-content/uploads/` so their old addresses keep working too.

## Publishing

Every push to `master` that touches `website/` is built and published to GitHub Pages by `.github/workflows/website.yml`.
