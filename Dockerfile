FROM kibana:5.0.0

RUN apt-get update
RUN apt-get -y install curl

COPY kibana.yml /opt/kibana/config/kibana.yml
COPY accenture-tech.svg /tmp/accenture-tech.svg
COPY dashboards /tmp/dashboards/
COPY load.sh /tmp/load.sh
RUN chmod +x /tmp/load.sh
RUN sed -i -e 's/\r$//' /tmp/load.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sed -i -e 's/\r$//' /entrypoint.sh

ENV ELASTICSEARCH_URL=elasticsearch:9200

VOLUME ["/tmp/dashboards"]

CMD ["/entrypoint.sh"]
