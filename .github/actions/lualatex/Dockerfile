FROM texlive/texlive:latest

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
