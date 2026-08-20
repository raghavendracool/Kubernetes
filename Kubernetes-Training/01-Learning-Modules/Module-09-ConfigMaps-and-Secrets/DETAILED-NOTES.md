# Detailed Notes — ConfigMaps and Secrets

## Configuration Should Not Require a New Image

The same application image should be reusable across dev/QA/prod, while configuration differs by environment. ConfigMaps and Secrets help keep those values outside the image.

## Environment Variable vs Volume

Environment variables are simple, but a running process does not automatically see changes made later. Mounted configuration files can be refreshed by Kubernetes, but the application must reread them.

## Secret Reality

This is reversible encoding:

```bash
printf 'password' | base64
```

Therefore base64 is not encryption. Protect Secrets through RBAC, etcd encryption controls appropriate to the platform, secure Git practices and an external secret-management strategy when required.

## Operational Pattern

A configuration change can be coupled with a rollout using checksum annotations or deployment automation so Pods restart predictably when consumed config changes.
