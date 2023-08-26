if [ ! -d ../env ]
then
    python -m venv ../env
fi

pip3 install wheel

pip3 install -r Requirements.txt
