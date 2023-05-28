FROM ubuntu:22.10
FROM python:3.9.16

WORKDIR /home

RUN apt-get update

RUN pip install --upgrade pip setuptools wheel

RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN pip install 'git+https://github.com/facebookresearch/detectron2.git'

RUN pip install detectron2 -f \
  https://dl.fbaipublicfiles.com/detectron2/wheels/cpu/torch1.10/index.html

RUN pip install timm

RUN pip install opencv-python

ADD . .


RUN mkdir -p datasets/coco
RUN mkdir -p datasets/lvis

RUN ln -s /datasets/coco/annotations datasets/coco/annotations
RUN ln -s /datasets/coco/train2017 datasets/coco/train2017
RUN ln -s /datasets/coco/val2017 datasets/coco/val2017


RUN mkdir models
RUN cd models

RUN wget https://github.com/ShoufaChen/DiffusionDet/releases/download/v0.1/torchvision-R-101.pkl

RUN wget https://github.com/ShoufaChen/DiffusionDet/releases/download/v0.1/swin_base_patch4_window7_224_22k.pkl

RUN cd ..

ENTRYPOINT python demo.py --config-file configs/diffdet.coco.res50.yaml \
    --input images/image.jpg --output images/result.jpg --opts MODEL.DEVICE cpu MODEL.WEIGHTS diffdet_coco_res50_300boxes.pth \
    && python test.py