FROM   debian:stable-slim
MAINTAINER RaviharaV
RUN echo RaviharaV
CMD echo RaviharaV
COPY . .


RUN apt-get update && apt-get install -y --no-install-recommends python build-essential cmake nodejs git-core uglifyjs ca-certificates default-jre-headless
RUN apt-get update && apt-get install -y wget python3 python3-pip p7zip-full

RUN wget --no-check-certificate "http://abrok.eu/stockfish/latest/linux/stockfish_x64_modern.zip" -O stockfish_x64_modern

RUN bash makefish.sh
RUN wget --no-check-certificate "https://data.stockfishchess.org/nn/nn-3c0aa92af1da.nnue" -O nn-3c0aa92af1da.nnue

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x stockfish_x64_modern

CMD python3 run.py
