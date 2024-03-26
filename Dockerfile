FROM ghcr.io/staticrocket/ti-debian:bookworm-slim

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		gcc \
		python3 \
		python3-dev \
		python3-pip \
		python3-pyqt5 \
		python3-pyqt5.qtopengl \
		qtwayland5 \
	&& echo "**** cleanup ****" \
		&& apt-get autoremove \
		&& apt-get clean \
		&& rm -rf \
			/tmp/* \
			/var/lib/apt/lists/* \
			/var/tmp/* \
			/var/log/*

RUN --mount=type=bind,source=requirements.txt,target=/app/requirements.txt \
	pip3 install -r requirements.txt -vvv --break-system-packages

ENV PYTHONPATH="/usr/lib/python3/dist-packages/:/usr/local/lib/python3.11/site-packages"

COPY Industrial_Visualizer/ /app/

ARG TIEVM
RUN test -n "$TIEVM" \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		ti-img-rogue-umlibs-$TIEVM \
	&& echo "**** cleanup ****" \
		&& apt-get autoremove \
		&& apt-get clean \
		&& rm -rf \
			/tmp/* \
			/var/lib/apt/lists/* \
			/var/tmp/* \
			/var/log/* \
	|| echo "Not installing TI specific graphics packages!"

#CMD ["python", "Industrial_Visualizer/gui_main.py"]
CMD ["/bin/bash"]
