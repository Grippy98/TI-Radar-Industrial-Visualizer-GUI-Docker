FROM ghcr.io/staticrocket/ti-debian:bookworm-slim

WORKDIR /app


COPY requirements.txt .
RUN apt-get update && apt-get install wget python3 python3-pip qtbase5-dev qtwayland5 python3-pyqt5 python3-pyqt5.qtopengl -y #python3-numpy python3-sklearn python3-sklearn-lib -y
#RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt -vvv --break-system-packages

ENV PYTHONPATH="/usr/lib/python3/dist-packages/:/usr/local/lib/python3.11/site-packages"

COPY . .

RUN apt-get install -y --no-install-recommends git ca-certificates python3 python3-venv asciidoc libglib2.0-0 libgl1 libfontconfig1 libxcb-cursor0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev gcc python3-dev
RUN apt-get install -y libx11-6 libxext-dev libxrender-dev libxinerama-dev libxi-dev libxrandr-dev libxcursor-dev libxtst-dev tk-dev && rm -rf /var/lib/apt/lists/*

#RUN test "$TIEVM" -eq "true" && wget https://raw.githubusercontent.com/TexasInstruments/ti-debpkgs/main/ti-debpkgs.sources && cp ti-debpkgs.sources /etc/apt/sources.list.d && apt-get update && apt-get install -y ti-img-rogue-umlibs-am62 && apt reinstall libegl1-mesa libegl-mesa0 libgles2-mesa || echo "Not installing packages!"
#test -n $TIEVM &&
RUN wget https://raw.githubusercontent.com/TexasInstruments/ti-debpkgs/main/ti-debpkgs.sources && cp ti-debpkgs.sources /etc/apt/sources.list.d && apt-get update && apt-get install -y ti-img-rogue-umlibs-$TIEVM && apt reinstall -y libegl1-mesa libegl-mesa0 libgles2-mesa || echo "Not installing TI specific graphics packages!"

#RUN git clone https://github.com/TexasInstruments/ti-debpkgs
#RUN cp ti-debpkgs/ti-debpkgs.sources /etc/apt/sources.list.d/
#RUN apt-get update

#RUN apt-get install -y ti-img-rogue-umlibs-am62
#RUN apt reinstall libegl1-mesa libegl-mesa0 libgles2-mesa

#CMD ["python", "Industrial_Visualizer/gui_main.py"]
CMD ["/bin/bash"]
