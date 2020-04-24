--------------------------------------------------------------------------------
  + [00 Introduction]
  + [01 Build Host]
  + [02 Build Bastion]
  + [03 Build Gateway]
  + [04 Setup_Dns]
  + [05 Setup HAProxy]
  + [06 Setup Dhcp]
  + [07 Setup Nginx]
  + [08 Setup Tftpd]
  + [09 Deploy Cloud]
  + [10 Configure Cloud]
--------------------------------------------------------------------------------
```sh
 oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'
 oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name' | xargs oc adm certificate approve
```

```sh
 htpasswd -c -B -b users.htpasswd ocadmin admin
 oc create secret generic htpass-secret --from-file=htpasswd=./users.htpasswd -n openshift-config
 oc apply -f ~/.ccio/ocp-mini-stack/module/cloudctl/aux/config/htpasswd.yaml
 oc adm policy add-cluster-role-to-user cluster-admin ocadmin
```
--------------------------------------------------------------------------------
## Testing
#### Istio
```sh
https://github.com/raffaelespazzoli/openshift-enablement-exam/tree/master/misc4.0/ServiceMesh
```
--------------------------------------------------------------------------------
[00 Introduction]:/00_Introduction.md
<!-- Markdown link & img dfn's -->
[00 Introduction]:/00_Introduction.md
[01 Build Host]:/01_Build_Host.md
[02 Build Bastion]:/02_Build_Bastion.md
[03 Build Gateway]:/03_Build_Gateway.md
[04 Setup_Dns]:/04_Setup_DNS.md
[05 Setup HAProxy]:/05_Setup_HAProxy.md
[06 Setup Dhcp]:/06_Setup_DHCP.md
[07 Setup Nginx]:/07_Setup_Nginx.md
[08 Setup Tftpd]:/08_Setup_Tftpd.md
[09 Deploy Cloud]:/09_Deploy_Cloud.md
[10 Configure Cloud]:/10_Configure_Cloud.md
