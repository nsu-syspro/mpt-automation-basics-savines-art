FROM ubuntu:22.04
RUN apt-get update && apt-get install -y make jq gcc bash && mkdir wordcount_app
WORKDIR /wordcount_app
COPY . .
RUN make && make check
CMD ["./build/wordcount"]
