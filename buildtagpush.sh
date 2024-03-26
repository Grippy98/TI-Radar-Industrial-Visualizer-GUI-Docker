docker build -t radar_gui .
docker image tag radar_gui grippy98/radargui_industrial_visualizer
docker push grippy98/radargui_industrial_visualizer
