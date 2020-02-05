base_image: download_centos7_cloud build_cloud_init_iso
download_centos7_cloud:
	if ! [ -f images/centos7_cloud.qcow2 ]; then\
		curl -o images/centos7_cloud.qcow2 "http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2";\
	fi
build_cloud_init_iso:
	cloud-localds cloud_init.iso cloud-init.yml
run_base_image: base_image
	qemu-img create -f qcow2 -F qcow2 -b centos7_cloud.qcow2 images/centos7test.qcow2
	sudo virt-install \
  		--memory 1024 \
  		--vcpus 1 \
  		--name centos7test \
  		--disk images/centos7test.qcow2,device=disk \
  		--disk images/cloud_init.iso,device=cdrom \
  		--os-type Linux \
  		--os-variant "centos7.0" \
  		--virt-type kvm \
  		--graphics none \
  		--network default \
  		--import
clean:
	sudo virsh shutdown centos7test
	sudo virsh undefine centos7test
	sudo rm -f images/centos7test.qcow2 images/cloud_init.iso
