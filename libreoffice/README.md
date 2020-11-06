This script builds a Slackware package from the official binary (RPM's)
distributed by The Document Foundation.  Everything needed by the
application should be built statically into it, so there aren't any
dependencies not satisfied by a normal installation.

Be sure to look at the script for some optional things you can do when
building.

For: 

    version >= 6.2.0

> NOTE: 
> See the separate SlackBuild script for the language packs.
> Modified from https://slackbuilds.org/repository/14.2/office/libreoffice, patched to remove dependence of 'avahi'.
> Since replacing 'avahi' with a simulating function of void, 'Remote Presentation' is unavailable here.
