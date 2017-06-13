# Copyright 2017 The Kubernetes Authors.
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

clean: clean-aws/efs clean-ceph/cephfs clean-flex clean-gluster/block clean-local-volume/provisioner clean-nfs-client clean-nfs

test: test-aws/efs test-local-volume/provisioner test-nfs

aws/efs:
	cd aws/efs; \
	make container
.PHONY: aws/efs

test-aws/efs:
	cd aws/efs; \
	make test
.PHONY: test-aws/efs

clean-aws/efs:
	cd aws/efs; \
	make clean
.PHONY: clean-aws/efs

ceph/cephfs: 
	cd ceph/cephfs; \
	go build cephfs-provisioner.go; \
	docker build -t cephfs-provisioner .
.PHONY: ceph/cephfs

clean-ceph/cephfs:
	cd ceph/cephfs; \
	rm -f cephfs-provisioner
.PHONY: clean-ceph/cephfs

flex:
	cd flex; \
	make container
.PHONY: flex

clean-flex:
	cd flex; \
	make clean
.PHONY: clean-flex

gluster/block:
	cd gluster/block; \
	make container
.PHONY: gluster/block

clean-gluster/block:
	cd gluster/block; \
	make clean
.PHONY: clean-gluster/block

local-volume/provisioner:
	cd local-volume/provisioner; \
	make container
.PHONY: local-volume/provisioner

test-local-volume/provisioner:
	cd local-volume/provisioner; \
	go test ./...
.PHONY: test-local-volume/provisioner

clean-local-volume/provisioner:
	cd local-volume/provisioner; \
	make clean
.PHONY: clean-local-volume/provisioner

nfs-client:
	cd nfs-client; \
	./build.sh; \
	docker build -t quay.io/external_storage/nfs-client-provisioner .
.PHONY: nfs-client

clean-nfs-client:
	cd nfs-client; \
	rm -f nfs-client-provisioner
.PHONY: clean-nfs-client

nfs: 
	cd nfs; \
	make container
.PHONY: nfs

test-nfs: 
	cd nfs; \
	make test
.PHONY: test-nfs

clean-nfs:
	cd nfs; \
	make clean
.PHONY: clean-nfs
