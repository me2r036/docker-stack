FROM docker.elastic.co/beats/filebeat:6.0.1
USER root
#RUN mkdir /usr/share/filebeat/prospectors.d1
COPY prospectors.d/default.yml /usr/share/filebeat/prospectors.d/default.yml
RUN chown root:filebeat /usr/share/filebeat/prospectors.d/default.yml
RUN chmod 640 /usr/share/filebeat/prospectors.d/default.yml
USER filebeat
