FROM python:3.7

RUN apt-get update && \
    apt-get -y install python3-dev gcc libc-dev musl-dev

COPY . /app
WORKDIR /app

RUN pip3 install poetry target-csv==0.3.0 && \
    poetry install --no-dev

CMD poetry run tap-tableau-wrangler --config tap_config.json --catalog catalog.json | target-csv -c target_config.json > /output/state.json
