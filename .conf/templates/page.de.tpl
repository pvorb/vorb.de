<%
function pad(n) { return (n<10)? '0'+n:n; }
function getDate(d) {
  return pad(d.getDate())+'.'+pad(d.getMonth()+1)+'.'+d.getFullYear();
}
%><!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8">
    <title><%= title %> | <%= siteTitle %></title>
    <link rel="stylesheet" href="/res/diego.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="/favicon.ico">
    <meta name="author" content="<%= author %>">
<%
if (locals.tags) {
%>
    <meta name="keywords" content="<%= tags.join(", ") %>">
<%
}
%>
  </head>
  <body>
    <nav id="nav">
      <ol id="path"><%
  var path = _id.replace(/\/index\.html$/, '');
  path = path.split('/');
  var pathref = '/';

  for (var i = 0; i < path.length; i++) {
    if (i == 0) {%>
        <li><a href="<%= pathref %>">vorb.de</a>
<%  } else if (i < path.length - 1) {%>
        <li><a href="<%= pathref %>"><%- path[i] %></a>
<%  } else {%>
        <li><%- path[i] %>
<%  }
    pathref += path[i+1]+'/';
  }
%>
      </ol>
      <ol id="access">
        <li><a href="#top" title="Zum Anfang" id="back" accesskey="t">↑</a>
        <li><a href="#nav">Navigation</a>
        <li><a href="#content">Content</a>
      </ol>
      <form id="search" action="/search.html" method="GET">
        <input type="search" name="s" accesskey="s" placeholder="Suche">
      </form>
    </nav>
    <article id="content">
      <header>
        <h1><%= title %></h1>
<% if (locals.teaser) { %>
        <figure class="teaser">
          <img src="<%= teaser %>">
        </figure>
<% } %>
      </header>
      <section>
        <%- __content %>
      </section>
<% if (locals.modified) { %>
      <footer class="meta">
        <p>Last modified: <%- getDate(modified) %></p>
      </footer>
<% } %>
    </article>
    <footer id="about">
      <p>© 2008-<%= (new Date()).getFullYear() %> – <%= siteAuthor %>.
        <a href="http://paul.vorba.ch/">Contact</a>.</p>
    </footer>
  </body>
</html>
