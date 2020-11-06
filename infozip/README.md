This is a patched version of unzip, with patches converting from ubuntu unzip package.

The patches add 2 important usage with option -O and -I:

    -O CHARSET  specify a character encoding for DOS, Windows and OS/2 archives
    -I CHARSET  specify a character encoding for UNIX and other archives

They are useful when you need to compress/extract files between UNIX/Linux and Windows using .zip

