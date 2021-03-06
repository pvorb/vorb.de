---
title: "Book review: “Haskell Financial Data Modeling and Predictive Analytics”"
alias: review-haskell-financial-data-modeling.md

author: Paul Vorbach
created-at: 2014-01-08

tags: [ english, haskell, dev, lang, fp ]
locale: en-US

template: post-diego.ftl
teaser:
  image-url: /2014/haze.jpg
...


A few weeks ago, I've been asked to review the book "Haskell Financial Data
Modeling and Predictive Analytics" by Pavel Ryzhov. I never got such a request
before, so I thought "Hey, why not have a look at it". So I accepted to write a
review of the book, once I read it.


## Financial Data Modeling?

You might ask what I have to do with financial data modeling. Well, I don't know
either but it's never too late to explore new fields... ;-)


## The Haskell Platform

Haskell is a functional programming language, that has been around [for more
than 20 years][haskell-years]. And as functional programming languages are being
[hyped everywhere][scala] these days, learning another one can't be
wrong.

[haskell-years]: /tag/lang.html#programming-languages
[scala]: /2013/scala.html

I already had a look at Haskell in August and September 2012 when I started
reading the free introductory book ["Learn You a Haskell for Great Good!"][lyah]
by Miran Lipovača, which I really enjoyed. It's a brilliant introduction to
Haskell and its style is really fun to read. But this review is not about
Miran's book...

[lyah]: http://learnyouahaskell.com/


## The Book

After a short chapter on how to setup all necessary tools on various platforms
(which tends to focus on Mac OS X), the author introduces the most important
principles of Haskell without going too much into detail. If you haven't seen
any Haskell before, the introduction to the language might be a little too
short. Probably enough for a financial programmer who wants to get productive.

However the introduction was ideal for me as I haven't programmed much Haskell
since "Learn You a Haskell". You'll also be confronted with the first major
shortcomings of the book: Almost every code example isn't part of the book
itself, but is only available as part of a ZIP archive that can be downloaded
along with the e-book. This might be acceptable when you are reading the book
with a normal PC. When you are reading the book with an e-book reader, you can't
access the code examples. Too bad.

During my read I learned the most by studying the code examples, since the
explanations often don't go much into detail. It's hard to follow the author's
chain of thought even when you have the examples at hand.

The next chapter, "Getting your Hands Dirty", starts by explaining (file) I/O
and parsing in Haskell. It introduces the Attoparsec library which can handle
CSV files in a type-safe manner. Additionally, the concept of managing data by
using an object relational mapper is introduced and shown by examples.

The following chapter is all about "measuring tick intervals". It provides
solutions for maximum likelihood estimation as well as other models for several
financial processes and the secant root finding algorithm. Towards the end of
the chapter, [QuickCheck] is introduced, which is a great library for testing
Haskell programs _automagically_. In QuickCheck, a programmer can define
properties that a function must satisfy and QuickCheck randomly generates cases
the function will be tested on. This is a great addition to conventional unit
testing. I also found [ScalaCheck], the Scala version of QuickCheck, very
helpful for writing Scala test cases.

[QuickCheck]: http://www.cse.chalmers.se/~rjmh/QuickCheck/
[ScalaCheck]: http://scalacheck.org/

I had a hard time reading chapter 4 and 5, since they are diving deep into
financial mathematics. That's why I can hardly give a rating of the quality of
these chapters.

One interesting part can be found in chapter 5. Here, parallel computations are
introduced and shown by example.

Chapter 6 – the last one – gives an introduction to Cabal, the Haskell build
system. It can be used to build a project, manage dependencies, run tests and
more. So this is pretty much like Maven/Gradle/SBT for Java and Scala or NPM for
Node.js. It's an interesting way to round up the book with a chapter about Cabal
– I would have expected it at the beginning – but it's important to know Cabal
if you want to get started with Haskell.


## Conclusion

I would have found it better if the author had explained his code in more
detail, but that's just my opinion. The book is not for programmers who don't
have anything to do with financial programming. Wow, who could think of that?!
But it seems to be a neat introduction to financial programming in Haskell, if
you are willing to learn the language.


## Links

 1. Pavel Ryzhov: ["Haskell Financial Data Modeling and Predictive
    Analytics"](http://www.packtpub.com/haskell-financial-data-modeling-and-predictive-analytics/book?utm_source=Paul%20Vorbach),
    Packt Publishing, 2013.
