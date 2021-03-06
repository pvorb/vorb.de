---
title: File search in Node.js
alias: file-search-nodejs.md

author: Paul Vorbach
created-at: 2012-07-12
last-modified-at: 2013-02-13

tags: [ english, dev, nodejs ]
locale: en-US

template: post-milten.ftl
teaser:
  image-url: /2012/magnify.jpg
  author: Lukas Mathis
  url: http://www.flickr.com/photos/l_k_m/1464840438/
  license:
    name: CC BY-SA 2.0
    url: http://creativecommons.org/licenses/by-sa/2.0/
...

Since the German blog post [Volltextsuche] is the most clicked on this blog,
I’ll explain, how I realised the full-text search of this website with the help
of Node.js.


## Prerequisites

You need to be on a Linux/Unix machine, since the search uses native command
line commands like [`find`] and [`grep`] and you need to have [Node.js]
(v0.4.0+) installed. Maybe there is a similar way to do it on Windows, too.
I think you could install [Git for Windows](https://git-scm.com/downloads) and add
the `/bin` directory to your system `PATH` to use the same commands on Windows.
If somebody has a better solution (maybe one that works out of the box) he/she
may [leave a comment](/2012/file-search-nodejs.html#comments).


## Finding files on the command line

If you are in a Unix shell, you don’t have a nifty search box, that lets you
search for files in your current working directory. Instead, you have the
command `find`, that lets you search for files by specifying various arguments.

For example with `find . -name '*.txt'` you can search for all files (or
directories) ending in `.txt` in the current working directory and in any
subdirectories.

_But how would you search for the contents of a file?_

This is quite a bit more difficult to find out. There’s another command, `grep`,
that allows you to filter lines from `stdin` or from the contents of a given
file.

Usually, Unix shells allow you to use the pipe character `|` to combine
commands. This way, you can use `find` to first find all files of a specific
type and the to filter out all the files that contain a specific search string,
as follows:

~~~ bash
find . -name '*.html' | xargs grep 'example'
~~~

The command `xargs` makes sure, that the results of find are used as arguments
for grep, so that it reads the contents of each file. As a result, the command
returns a line seperated list of HTML files, that contain the string “example”.

To improve results and prevent errors, the command can still be improved.

~~~ bash
find . -iname '*.html' | xargs grep 'example' -isl
~~~

This way, it doesn’t matter if file names are upper- or lowercase and the text
search is also case insensitive. Binary content is ignored and warnings will be
suppressed.


## The basic code

Let’s have a look at the required JavaScript code.

What you need to write is a simple HTTP server, that parses the query part of
the URL from a HTTP GET request. The search module only takes one parameter,
`s`, like in `http://vorb.de/search.html?s=example`. This website (vorb.de) uses
a small REST framework of mine, [api], which enables me to register modules for
different URLs, but I’ll only show how to do it without any framework. This way
you can adapt the solution to your framework of choice ([express], [flatiron],
etc.).

You need to load several packages during start-up:

~~~ javascript
var http = require('http');
var url = require('url');
var exec = require('child_process').exec;
~~~

After that, define some other values:

~~~ javascript
// timeout in ms for a single search
var timeout = 10000;
// specify the root directory, where the search will begin
var root = process.cwd();
~~~

Now you can write the server code:

~~~ javascript
var server = http.createServer(function (req, resp) {
  // parse the request url
  // the query is everything after the '?'
  // the second param says that the query shall be evaluated
  var query = url.parse(req.url, true).query;

  // ensure both are != null or ''
  if (query && query.s) {
    // replace single with double quotes
    query.s = query.s.replace("'", '"');

    // run the search
    exec("find . -iname '*html' | xargs grep '"+query.s+
        "' -isl", {
          timeout: timeout,
          cwd: root
        }, function (err, stdout, stdin) {

      resp.writeHead(200, { 'Content-Type': 'text/html' });

      if (err) {
        resp.end('<p>Error on search</p>');
        console.log(err);
      }

      // split the results
      var results = stdout.split('\n');
      // remove last element (it’s an empty line)
      results.pop();

      resp.write('<h1>Search results</h1>\n<ul>');
      for (var i = 0; i < results.length; i++) {
        resp.write('<li>');
        resp.write(results[i]);
        resp.write('</li>');
      }
      resp.end('</ul>');
    });
  } else {
    resp.writeHead(200, { 'Content-Type': 'text/html' });
    return resp.end('<p>No results</p>');
  }
});

// listen on port 8080
server.listen(8080, function () {
  console.log('Server running at http://localhost:8080/');
});
~~~

You may [download the source file](/2012/file-search.js). You can start it on the
command line with `node file-search.js`. Then go to
[localhost:8080](http://localhost:8080/?s=test) try it. Of course you need to
create some HTML files first, if you want to find something.

Here’s how the result will look like:

![Screenshot of the search results page](/2012/search-results.png)


[Volltextsuche]: /2012/volltextsuche.html
[`find`]: https://en.wikipedia.org/wiki/Find
[`grep`]: https://en.wikipedia.org/wiki/Grep
[Node.js]: https://nodejs.org/
[npm]: https://npmjs.com/
[api]: https://github.com/pvorb/node-api
[express]: https://expressjs.com/
[flatiron]: https://github.com/flatiron/flatiron
