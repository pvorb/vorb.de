---
title: Why are comments not allowed in JSON?
alias: json-comments.md

author: Paul Vorbach
created-at: 2013-03-13

tags: [ english, dev, json, javascript ]
locale: en-US

template: post-diego.ftl
teaser:
  image-url: /2013/json.png
...

Every markup or data exchange format that I am aware of, supports the definition
of comments. There’s only one exception: [JSON].

I am dealing with JSON a lot these days. Recently, many developers prefer JSON
over the more complex [XML] that’s been around for a while now. And that’s why
it’s common practice to implement [REST]-APIs in JSON instead of XML. Another
common use case for JSON documents is configuration of all kinds of software
systems. Regularly I feel a need to comment some lines of such JSON documents.
Maybe it’s just to clarify my intention or to make some notes for later.

If you work with JSON a lot, you will once come to a point where it would be
great if you could have comments on some properties, a specific value or the
like. Since JSON is a subset from JavaScript, one could think it would allow
comments like in this example:

~~~ javascript
{
  "key": "value" // comment
}
~~~

But it doesn’t. The [JSON website][JSON] doesn’t say much about this
circumstance. The [corresponding RFC][JSON RFC] doesn’t either. Douglas
Crockford, who is said to have discovered JSON, gives
[the answer][The JSON Saga] in his talk “The JSON Saga”. He states that
initially you were allowed to use `// comments after a double slash` as well as
`/* block comments */` in JSON. Later he decided to remove support for comments
because of three reasons:

 1. Dangerous practices

    > “People were putting instructions to the parser in comments, which was a
    > really bad thing, because that would totally break interoperability,
    > because this whole level of metalanguage wouldn’t be common, which would
    > be outside of the standard.”

 2. Unnecessary complexity

    > “[...] And for some of the ports to other languages about half of the
    > complexity of doing the thing was just doing the comments [...]”

 3. Alignment with [YAML]

I don’t really think that these are valid reasons for removing something as
quintessential as comments, but at least there are reasons for this decision.

There are two possible ways of working around the lack of comments (besides from
being frustrated and leaving them out).

 1. You can either agree on a special property that holds a comment for the
    surrounding object. For example:

    ~~~ json
    {
      "key": "value",
      "__comment": "defines a key and a value"
    }
    ~~~

 2. Or you could use another markup format that supports comments. Examples
    would be XML, YAML or the newer
    [HOCON (Human-Optimized Config Object Notation)][HOCON].

Personally, I think that YAML is a bloated spec and HOCON is preferably used to
configure software systems. Sometimes, bringing XML to client-side web
applications can be a real pain, so in-JSON comments often are the only
solution.


[JSON]: http://json.org/
[XML]: http://www.w3.org/XML/
[REST]: http://en.wikipedia.org/wiki/Representational_state_transfer
[JSON RFC]: http://tools.ietf.org/html/rfc4627.html
[The JSON Saga]: http://youtu.be/-C-JoyNuQJs?t=16m6s
[YAML]: http://yaml.org/
[HOCON]: https://github.com/typesafehub/config/blob/master/HOCON.md
