# Asterisk Server Deployment

Please note: I'm new to Asterisk so use with caution.

## Docker Operations

### Build Docker Image
docker build -t asterisk-22.1.1:latest .

### Run Docker Container 
``` bash
docker run -d -p 5060:5060/udp -p 4569:4569/udp -p 5060:5060 --name asterisk asterisk-22.1.1
```


## Requirements for MKDOCS

Install MKDOCS and dependencies
``` bash
pip install mkdocs
pip install mkdocs-material
pip install mkdocs-minify-plugin
```

Serve MKDOCS on port 8000
``` bash
python -m mkdocs serve
```

