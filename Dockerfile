FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y bc dos2unix && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY calculator.sh .

RUN dos2unix calculator.sh && chmod +x calculator.sh

CMD ["bash", "./calculator.sh"]
