---
title: How to build Tesseract on Cygwin
alias: tesseract-cygwin.md

author: Paul Vorbach
created-at: 2014-02-20

tags: [ english, howto, tesseract, ocr, c++, cygwin ]
locale: en-US

template: post-diego.ftl
teaser:
  image-url: /2014/build.jpg
...

[Tesseract](https://code.google.com/p/tesseract-ocr/) is the most accurate and
most adaptable open source OCR engine I know of.

For my master thesis, I needed to be able to change the inner workings of
Tesseract. That's why I had to compile it.

[Cygwin](http://www.cygwin.com/) is a set of GNU tools for Microsoft Windows
which gives you a POSIX environment on Windows.

Here, I'll document how to build Tesseract on Cygwin, because that is easier
than building on MinGW or in Visual Studio and it is not documented on the
[Compiling](https://code.google.com/p/tesseract-ocr/wiki/Compiling) wiki page.

## Installing Cygwin

 1. Download Cygwin from the [download page](http://cygwin.com/install.html)
    (both 32-bit and 64-bit versions will work).
 2. Run the installer.
 3. Use `C:\Cygwin` or `C:\Cygwin64` as root directory.
 4. When you are asked to select the desired packages, set _Base_, _Devel_ and
    _Graphics_ to _Install_. You can _Skip_ at least _Publishing_, _Gnome_ and
    _KDE_, probably even more, in order to save time during installation. Leave
    all other packages at _Default_.
 5. Continue the installation process until you are done.

## Installing Leptonica

In order to build tesseract, we need to build
[Leptonica](http://www.leptonica.org/) first.

 1. Open a Cygwin Terminal.
 2. Create a directory, where you can build the library.

    ~~~
    mkdir -p /opt/src && cd /opt/src
    ~~~
 3. Get the source.

    ~~~
    wget http://www.leptonica.org/source/leptonica-1.70.tar.gz
    ~~~

    Or use the latest source package from Leptonica's [downloads
    page](http://www.leptonica.org/download.html). Extract it.

    ~~~
    tar -xvf leptonica-1.70.tar.gz
    cd leptonica-1.70
    ~~~
 4. Since `giflib` is not available in Cygwin, we have to configure it
    accordingly.

    ~~~
    ./configure --without-giflib
    ~~~
 5. Build and install it.

    ~~~
    make
    make install
    make clean
    ~~~

## Installing Tesseract

 1. Go to `/opt/src`.

    ~~~
    cd /opt/src
    ~~~
 2. Download Tesseract's latest source distribution [from
    here](https://code.google.com/p/tesseract-ocr/downloads/list).

    ~~~
    wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
    tar -xvf tesseract-ocr-3.02.02.tar.gz
    cd tesseract-ocr
    ~~~
 3. Configure it.

    ~~~
    ./autogen.sh
    ./configure LDFLAGS=-L/usr/local/lib
    ~~~

 4. Build and install it.

    ~~~
    make
    make install
    make clean
    ~~~

## Verification

All training files have to be in `/usr/local/share/tessdata`. Download a
language data archive file from Tesseracts [downloads
page](https://code.google.com/p/tesseract-ocr/downloads/list), extract it and
move its contents to `/usr/local/share/tessdata`. You can also [train your own
language data](https://code.google.com/p/tesseract-ocr/wiki/TrainingTesseract3).
Then you'll be able to run Tesseract.

~~~
tesseract -l eng input.tif output
~~~

This will create a `output.txt` file with the OCR results.

If something is not working for you, leave a comment.
