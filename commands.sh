helm uninstall consul
helm upgrade --install consul ./  -f values.yaml  --set global.name=consul