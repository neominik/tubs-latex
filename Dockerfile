FROM aergus/latex

RUN apt-get update -q \
    && apt-get -qy install curl \
    && rm -rf /var/lib/apt/lists/*

RUN \
    # Get latest release tag
    curl "https://gitlab.ibr.cs.tu-bs.de/api/v4/projects/tubslatex%2Ftubslatex/releases" --output /tmp/releases \
    # alpha or full release
    && tagname=$(sed -E 's;^\[\{"name":"([0-9.alpha-]+)".*$;\1;g' /tmp/releases) \
    #
    # Get installer link of release
    && curl "https://gitlab.ibr.cs.tu-bs.de/api/v4/projects/tubslatex%2Ftubslatex/releases/$tagname" --output /tmp/releases \
    && installerurl=$(sed -E 's;.*"name":"Installations-Skript \(sh\)","url":"([a-z0-9:/\.=\?_-]+)",.*;\1;g' /tmp/releases) \
    && rm /tmp/releases \
    && curl $installerurl --output /tmp/tubslatex_installer

RUN sh /tmp/tubslatex_installer -d --noninteractive --latest-stable --del-local-font --getnonfreefonts \
    && rm /tmp/tubslatex_installer
