FROM python:3.8-alpine

ENV AWSCLI_VERSION='1.17.1'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}
RUN pip install --quiet --no-cache-dir mkdocs

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
