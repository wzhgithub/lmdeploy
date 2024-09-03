FROM adas-img.nioint.com/aigc/lmdeploy:0.5.3-cu12.2-loging-metric

# Should be in the lmdeploy root directory when building docker image
COPY . /opt/lmdeploy

WORKDIR /opt/lmdeploy

RUN --mount=type=cache,target=/root/.cache/pip cd /opt/lmdeploy &&\
    python3 -m pip install -r requirements.txt -i https://mirrors.cloud.tencent.com/pypi/simple &&\
    mkdir -p build && cd build &&\
    sh ../generate.sh &&\
    ninja -j$(nproc) && ninja install &&\
    cd .. &&\
    python3 -m pip install -e . &&\
    rm -rf build && \
    pip cache purge

ENV LD_LIBRARY_PATH=/opt/lmdeploy/install/lib:$LD_LIBRARY_PATH
ENV PATH=/opt/lmdeploy/install/bin:$PATH

# explicitly set ptxas path for triton
ENV TRITON_PTXAS_PATH=/usr/local/cuda/bin/ptxas
