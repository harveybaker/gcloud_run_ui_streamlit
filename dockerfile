# app/Dockerfile

FROM python:3.9-slim

WORKDIR /app

COPY /src/. /app/
COPY requirements.txt /tmp/

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git 

RUN pip3 install -r /tmp/requirements.txt

RUN ls -a && \
    python --version && \
    python -m pip list

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# ENTRYPOINT ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
ENTRYPOINT ["streamlit", "run", "ui/app.py"]
