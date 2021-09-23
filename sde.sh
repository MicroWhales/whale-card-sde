#!/bin/bash

case $1 in
    setup)
    # Create local directory if not exist
    abs_path=$(pwd)
    dir_name="${abs_path}/local/"
    if [ -d ""${dir_name}"" ]
    then
        echo "*** Local directory found, checking relevent Repos"
    else
        echo "*** Creating a local directory..."
        mkdir local
        echo "*** Created..."
        echo "*** Checking relevant repos..."
    fi

    cd local/

    # Clone WC API if not exist
    abs_path=$(pwd)
    dir_name="${abs_path}/whale-cards-core/"
    if [ -d ""${dir_name}"" ]
    then
        echo "*** Core Api found..."
    else
        echo "*** Pulling Core..."
        git clone https://github.com/MicroWhales/whale-cards-core.git
    fi

    cd whale-cards-core/
    python3 -m venv venv
    source venv/bin/activate
    pip3 install -r requirements.txt
    cd ..
    deactivate

    # Clone WC Web if not exist
    abs_path=$(pwd)
    dir_name="${abs_path}/whale-cards-web-app/"
    if [ -d ""${dir_name}"" ]
    then
        echo "*** Web found..."
    else
        echo "*** Pulling Web..."
        git clone https://github.com/MicroWhales/whale-cards-web-app.git
        # Set up virtual environment and download dependencies
    fi

    echo "*** Set up complete"
    ;;
    run-core)
    cd local/whale-cards-core
    source venv/bin/activate
    pip3 install -r requirements.txt
    python3 app.py
    ;;
    routes)
    cd local/whale-cards-core
    source venv/bin/activate
    pip3 install -r requirements.txt
    EXPORT FLASK_APP=api.py
    flask routes
    ;;
    *)
    echo "Choose script functions - "
    echo "./wmc.sh setup - create local directory and clone relevant repos"
    echo "./wmc.sh run-core - starts core API server on localhost:5000"
    echo "./wmc.sh routes - displays available endpoints on core
    ;;
esac