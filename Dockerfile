FROM --platform=linux/amd64 python:3.9.17


RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m arcetl  && echo "arcetl:arcetl" | chpasswd && adduser arcetl sudo
RUN echo "arcetl ALL=(ALL) NOPASSWD:ALL" >> /etc/passwd

RUN  apt-get update && apt-get install -y --no-install-recommends \
    python3-pip vim mlocate wget  \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# minio for s3
RUN mkdir /data
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio 
RUN chmod +x minio
ENV MINIO_ROOT_USER=admin
ENV MINIO_ROOT_PASSWORD=password
RUN /bin/bash -c 'nohup ./minio server /hostdata/miniodata --console-address ":9001" &' && sleep 4

EXPOSE 9000
EXPOSE 9001


# s3 setup
RUN pip3 --no-cache-dir install --upgrade awscli

# aws configure
ENV AWS_ACCESS_KEY_ID=admin
ENV AWS_SECRET_ACCESS_KEY=password
ENV AWS_DEFAULT_REGION=us-west-2>

COPY aws-config ~/.aws/config
COPY aws-credentials ~/.aws/credentials 

RUN aws configure  --profile minio

# minio client  \
#RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc 
#RUN chmod +x mc 
#RUN sudo mv mc /usr/local/bin/mc
#RUN mc alias set local http://127.0.0.1:9000 minioadmin minioadmin
#RUN mc admin info local



# Switch to user
#USER arcetl:arcetl
#WORKDIR /home/arcetl

RUN pip3 install  "awswrangler[ray,modin]"

CMD sleep infinity



