cd custom-image && docker build --build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
             --build-arg ANSIBLE_VERSION="2.9.4"       \
             --build-arg ANSIBLE_LINT_VERSION="5.0.7"   \
             --build-arg MITOGEN_VERSION="0.2.9"         \
             -t firasdotcom/consul:ansible . 

docker push firasdotcom/consul:ansible

######################################################################

cd ../ && helm upgrade --install consul ./  -f values.yaml  --set global.name=consul

helm uninstall consul