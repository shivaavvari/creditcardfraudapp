#stage 1 i need base image python 
from python:3.9.23-alpine3.21

#stage 2 i need a folder to save my code

workdir /app

#stage 3 i need to copy the dependency file
 
copy requirements.txt .
RUN apk update && \
    apk add --no-cache \
    gcc \
    g++ \
    musl-dev \
    python3-dev \
    pkgconfig \
    mariadb-dev \
    mariadb-connector-c-dev \
    # Added build-base and libc-dev, which can sometimes resolve wheel build errors
    build-base \
    libc-dev \
    # Clean up apk cache to reduce image size
    && rm -rf /var/cache/apk/*

#stage 4 run this dependency file 
run pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt
#stage 5 copy the entire code
copy . .

#stage 6 expose the ports 

expose 8000


#stage 7 Run the application 

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
