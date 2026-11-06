FROM eclipse-temurin:17-jre AS jre

FROM python:3.12-slim

# Spark 3.5 supports Java 8/11/17; Debian 13 only packages Java 21, so take Java 17 from Temurin.
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
COPY --from=jre /opt/java/openjdk /opt/java/openjdk

RUN apt-get update && apt-get install -y --no-install-recommends \
    procps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

CMD ["python", "src/main.py"]
