FROM python:3.11

WORKDIR /app

ENV DISPLAY=:0
ENV DISPLAY_CONFIGURATION=1024x768x24
ENV SCREEN_HEIGHT=1024
ENV SCREEN_WIDTH=768



ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype


COPY requirements.txt .
RUN apt-get update && apt-get install qtbase5-dev qtwayland5 python3-pyqt5 python3-pyqt5.qtopengl -y #python3-numpy python3-sklearn python3-sklearn-lib -y
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt -vvv

ENV PYTHONPATH="/usr/lib/python3/dist-packages/:/usr/local/lib/python3.11/site-packages"

COPY . .


RUN apt-get install -y --no-install-recommends git ca-certificates python3 python3-venv asciidoc libglib2.0-0 libgl1 libfontconfig1 libxcb-cursor0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libdbus-1-3 libyaml-dev gcc python3-dev
RUN apt-get install -y libx11-6 libxext-dev libxrender-dev libxinerama-dev libxi-dev libxrandr-dev libxcursor-dev libxtst-dev tk-dev && rm -rf /var/lib/apt/lists/*

CMD ["python", "Industrial_Visualizer/gui_main.py"]
#CMD ["/bin/bash"]
