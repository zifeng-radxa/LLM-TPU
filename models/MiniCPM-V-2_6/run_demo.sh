#!/bin/bash
# download bmodel
if [ ! -d "../../bmodels" ]; then
  mkdir ../../bmodels
fi

if [ ! -f "../../bmodels/minicpmv26_bm1684x_int4.bmodel" ]; then
  pip3 install dfss
  python3 -m dfss --url=open@sophgo.com:/ext_model_information/LLM/LLM-TPU/minicpmv26_bm1684x_int4.bmodel
  mv minicpmv26_bm1684x_int4.bmodel ../../bmodels
else
  echo "Bmodel Exists!"
fi

if [ ! -f "./python_demo/*cpython*" ]; then
  pushd python_demo
  rm -rf build && mkdir build && cd build
  cmake .. && make
  cp *cpython* ..
  popd
else
  echo "chat.so exists!"
fi

# run demo
echo $PWD
python3 python_demo/pipeline.py --model ../../bmodels/minicpmv26_bm1684x_int4.bmodel --tokenizer ./support/token_config --devid 0