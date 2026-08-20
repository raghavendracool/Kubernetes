# Detailed Notes — Labels, Selectors, Annotations and Namespaces

## Labels and Selectors Are Relationships

A Service does not know Deployment names. It selects Pods by labels. A Deployment's selector must match labels in its Pod template.

```text
Service selector: app=api
        |
        +--> Pod app=api
        +--> Pod app=api
```

A one-character selector mismatch can create a healthy Service object with zero backends.

## Labels vs Annotations

Use labels for values that will be selected/grouped, such as `app`, `environment`, `component`. Use annotations for metadata consumed by humans/tools when selection is not needed, such as documentation URLs or controller-specific settings.

## Namespaces

Namespaces scope names and many policies. `web` in namespace `dev` is a different object from `web` in `prod`.

Namespaces help organize RBAC, NetworkPolicy, ResourceQuota and lifecycle, but they are not automatically a strong multi-tenant isolation boundary without policies around them.
