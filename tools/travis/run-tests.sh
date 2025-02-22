#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

export KUBECONFIG="$(kind get kubeconfig-path)"

###
# Now run the tests provided in the Chart to verify the deployment
###
if helm test ow4travis --timeout 2400; then
    echo "PASSED! Deployment verification tests passed."
else
    echo "FAILED: Deployment verification tests failed."
    kubectl logs -n openwhisk -low-testpod=true
    exit 1
fi
