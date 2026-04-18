FROM python:3.12-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends bash curl ca-certificates xz-utils \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash

ENV PATH="/root/.moon/bin:${PATH}"

COPY . /app

ENV PYTHONUNBUFFERED=1
ENV HOST=0.0.0.0
ENV PORT=4173

EXPOSE 4173

CMD ["./scripts/start_hosted.sh"]
