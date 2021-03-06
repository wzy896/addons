#!/usr/bin/env bash
# Copyright 2019 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ==============================================================================
# usage: bash tools/testing/build_and_run_tests.sh

set -x -e

export CC_OPT_FLAGS='-mavx'

# Check if python3 is available. On Windows VM it is not.
if [ -x "$(command -v python3)" ]; then
  PYTHON_BINARY=python3
else
  PYTHON_BINARY=python
fi

$PYTHON_BINARY -m pip install -r tools/install_deps/pytest.txt -e ./
$PYTHON_BINARY ./configure.py
bash tools/install_so_files.sh
$PYTHON_BINARY -m pytest -v --durations=25 ./tensorflow_addons
