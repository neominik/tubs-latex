FROM blang/latex

RUN apt-get update -q && apt-get install -qy wget && rm -rf /var/lib/apt/lists/* \
  && wget "http://tubslatex.ejoerns.de/1.1.0/tubslatex_1.1.0.tds.zip" \
  && unzip -d /usr/local/share/texmf/ tubslatex_1.1.0.tds.zip \
  && rm tubslatex_1.1.0.tds.zip \
  && mktexlsr \
  && updmap-sys --nomkmap --nohash --enable Map=NexusProSans.map \
  && updmap-sys --nomkmap --nohash --enable Map=NexusProSerif.map \
  && updmap-sys
