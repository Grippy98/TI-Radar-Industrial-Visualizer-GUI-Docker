FROM ghcr.io/staticrocket/ti-debian:bookworm-slim

WORKDIR /app

COPY requirements.txt .
RUN apt-get update && apt-get install wget python3 python3-pip qtbase5-dev qtwayland5 python3-pyqt5 python3-pyqt5.qtopengl -y #python3-numpy python3-sklearn python3-sklearn-lib -y

RUN pip3 install -r requirements.txt -vvv --break-system-packages

ENV PYTHONPATH="/usr/lib/python3/dist-packages/:/usr/local/lib/python3.11/site-packages"

COPY . .

RUN apt-get install -y --no-install-recommends git ca-certificates python3 python3-venv asciidoc libglib2.0-0 libgl1 libfontconfig1 libxcb-cursor0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev gcc python3-dev

ARG TIEVM
RUN test -n "$TIEVM" \
   && apt-get update \
   && apt-get install -y \
      ti-img-rogue-umlibs-$TIEVM \
   && echo "**** cleanup ****" \
      && apt-get autoremove \
      && apt-get clean \
      && rm -rf \
         /tmp/* \
         /var/lib/apt/lists/* \
         /var/tmp/* \
         /var/log/* || echo "Not installing TI specific graphics packages!" 


#CMD ["python", "Industrial_Visualizer/gui_main.py"]
CMD ["/bin/bash"]
