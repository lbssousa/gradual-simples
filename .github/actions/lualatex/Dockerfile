ARG TEXLIVE_RELEASE=2022
ARG TEXLIVE_SNAPSHOT=2022.07.10
ARG LILYPOND_RELEASE=2.22.2
ARG REVISION=3
FROM ghcr.io/lbssousa/texlive-music:TL${RELEASE}-${TEXLIVE_SNAPSHOT}-LilyPond-${LILYPOND_RELEASE}-${REVISION}

LABEL maintainer="Laércio de Sousa <lbsousajr@gmail.com>"
LABEL repository="https://github.com/lbssousa/gradual-simples"
LABEL homepage="https://github.com/lbssousa/gradual-simples"

LABEL com.github.actions.name="Construir PDF"
LABEL com.github.actions.description="Construir os documentos PDF com lualatex."
LABEL com.github.actions.icon="code"
LABEL com.github.actions.color="blue"

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
