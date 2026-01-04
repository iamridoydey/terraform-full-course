# Azure Service Principal for RBAC Demo

This repository demonstrates how to create and use an **Azure Active Directory Service Principal** for role‑based access control (RBAC). A Service Principal is a dedicated identity used by applications, scripts, or CI/CD pipelines to authenticate against Azure without relying on a personal user account.

---

## 📌 Command Overview

The core command used here is:

```bash
az ad sp create-for-rbac -n az-demo --role="Contributor" --scopes="/subscriptions/$SUBSCRIPTION_ID"
```
