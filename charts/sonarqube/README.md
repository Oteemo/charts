# SonarQube

[SonarQube](https://www.sonarqube.org/) is an open sourced code quality scanning tool.

## Introduction

This chart bootstraps a SonarQube instance with a PostgreSQL database.

## Prerequisites

- Kubernetes 1.10+

## Installing the chart

To install the chart:

```bash
helm repo add oteemocharts https://oteemo.github.io/charts
helm install oteemocharts/sonarqube
```

The above command deploys Sonarqube on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

The default login is admin/admin.

## Uninstalling the chart

To uninstall/delete the deployment:

```bash
$ helm list
NAME        REVISION    UPDATED                     STATUS      CHART           NAMESPACE
kindly-newt 1           Mon Oct  2 15:05:44 2017    DEPLOYED    sonarqube-0.1.0  default
$ helm delete kindly-newt
```

## Ingress Paths

Some cloud may need the path to be /* instead of /. Try this first if you are having issues getting traffic through the ingress.

## Configuration

The following table lists the configurable parameters of the Sonarqube chart and their default values.

| Parameter                             | Description                                                                                                                 | Default                                          | 
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | 
| `replicaCount`                        | Number of replicas deployed                                                                                                 | `1`                                              | 
| `schedulerName`                       | Kubernetes scheduler name                                                                                                   | None                                             | 
| `deploymentStrategy`                  | Deployment strategy                                                                                                         | `{}`                                             | 
| `image.repository`                    | image repository                                                                                                            | `sonarqube`                                      | 
| `image.tag`                           | `sonarqube` image tag.                                                                                                      | `8.5-community`                                  | 
| `image.pullPolicy`                    | Image pull policy                                                                                                           | `IfNotPresent`                                   | 
| `image.pullSecret`                    | imagePullSecret to use for private repository                                                                               |                                                  | 
| `command`                             | command to run in the container                                                                                             | `nil` (need to be set prior to 6.7.6, and 7.4)   | 
| `elasticsearch.configureNode`         | [DEPRECATED] Use initSysctl.enabled instead.                                                                                | `true`                                           | 
| `elasticsearch.bootstrapChecks`       | Enables/disables Elasticsearch bootstrap checks                                                                             | `true`                                           | 
| `securityContext.fsGroup`             | Group applied to mounted directories/files                                                                                  | `999`                                            | 
| `containerSecurityContext`            | SecurityContext for sonarqube container                                                                                     | `{}`                                             | 
| `initContainers.image`                | Change init container image                                                                                                 | `busybox:1.32`                                   | 
| `initContainers.securityContext`      | SecurityContext for init containers                                                                                         | `nil`                                             | 
| `initContainers.resources`            | Resources for init containers                                                                                               | `{}`                                             | 
| `ingress.enabled`                     | Flag for enabling ingress                                                                                                   | false                                            | 
| `ingress.labels`                      | Ingress additional labels                                                                                                   | `{}`                                             | 
| `ingress.hosts[0].name`               | Hostname to your SonarQube installation                                                                                     | `sonar.organization.com`                         | 
| `ingress.hosts[0].path`               | Path within the URL structure                                                                                               | /                                                | 
| `ingress.hosts[0].serviceName`        | Optional field to override the default serviceName of a path                                                                | None                                             | 
| `ingress.hosts[0].servicePort`        | Optional field to override the default servicePort of a path                                                                | None                                             | 
| `ingress.tls`                         | Ingress secrets for TLS certificates                                                                                        | `[]`                                             | 
| `livenessProbe.sonarWebContext`       | SonarQube web context for livenessProbe                                                                                     | /                                                | 
| `readinessProbe.sonarWebContext`      | SonarQube web context for readinessProbe                                                                                    | /                                                | 
| `service.type`                        | Kubernetes service type                                                                                                     | `ClusterIP`                                      | 
| `service.externalPort`                | Kubernetes service port                                                                                                     | `9000`                                           | 
| `service.internalPort`                | Kubernetes container port                                                                                                   | `9000`                                           | 
| `service.labels`                      | Kubernetes service labels                                                                                                   | None                                             | 
| `service.annotations`                 | Kubernetes service annotations                                                                                              | None                                             | 
| `service.loadBalancerSourceRanges`    | Kubernetes service LB Allowed inbound IP addresses                                                                          | None                                             | 
| `service.loadBalancerIP`              | Kubernetes service LB Optional fixed external IP                                                                            | None                                             | 
| `persistence.enabled`                 | Flag for enabling persistent storage                                                                                        | false                                            | 
| `persistence.annotations`             | Kubernetes pvc annotations                                                                                                  | `{}`                                             | 
| `persistence.existingClaim`           | Do not create a new PVC but use this one                                                                                    | None                                             | 
| `persistence.storageClass`            | Storage class to be used                                                                                                    | ""                                               | 
| `persistence.accessMode`              | Volumes access mode to be set                                                                                               | `ReadWriteOnce`                                  | 
| `persistence.size`                    | Size of the volume                                                                                                          | 10Gi                                             | 
| `persistence.volumes`                 | Specify extra volumes. Refer to ".spec.volumes" specification                                                               | []                                               | 
| `persistence.mounts`                  | Specify extra mounts. Refer to ".spec.containers.volumeMounts" specification                                                | []                                               | 
| `serviceAccount.create`               | If set to true, create a serviceAccount                                                                                     | false                                            | 
| `serviceAccount.name`                 | Name of the serviceAccount to create/use                                                                                    | `sonarqube-sonarqube`                            | 
| `serviceAccount.annotations`          | Additional serviceAccount annotations                                                                                       | `{}`                                             | 
| `account.adminPassword`               | Custom admin password                                                                                                       | `"admin"`                                        | 
| `account.currentAdminPassword`        | Current admin password                                                                                                      | `"admin"`                                        | 
| `curlContainerImage`                  | Curl container image                                                                                                        | `"curlimages/curl:latest"`                       | 
| `sonarProperties`                     | Custom `sonar.properties` file                                                                                              | None                                             | 
| `sonarSecretProperties`               | Additional `sonar.properties` file to load from a secret                                                                    | None                                             | 
| `caCerts.image`                       | Change init CA certificates container image                                                                                 | `adoptopenjdk/openjdk11:alpine`                  | 
| `caCerts.secret`                      | Name of the secret containing additional CA certificates                                                                    | `nil`                                            | 
| `jvmOpts`                             | Values to add to SONARQUBE_WEB_JVM_OPTS                                                                                     | `""`                                             | 
| `env`                                 | Environment variables to attach to the pods                                                                                 | `nil`                                            | 
| `sonarSecretKey`                      | Name of existing secret used for settings encryption                                                                        | None                                             | 
| `postgresql.enabled`                  | Set to `false` to use external server                                                                                       | `true`                                           | 
| `postgresql.existingSecret`           | Secret containing the password of the external Postgresql server                                                            | `null`                                           | 
| `postgresql.postgresqlServer`         | Hostname of the external Postgresql server                                                                                  | `null`                                           | 
| `postgresql.postgresqlUsername`       | Postgresql database user                                                                                                    | `sonarUser`                                      | 
| `postgresql.postgresqlPassword`       | Postgresql database password                                                                                                | `sonarPass`                                      | 
| `postgresql.postgresqlDatabase`       | Postgresql database name                                                                                                    | `sonarDB`                                        | 
| `postgresql.service.port`             | Postgresql port                                                                                                             | `5432`                                           | 
| `jdbcDatabaseType`                    | Type of the JDBC Database driver                                                                                            | `postgreql`                                      | 
| `jdbcUrlOverride`                     | Overrides default JDBC URL creation                                                                                         | None                                             | 
| `annotations`                         | Sonarqube Pod annotations                                                                                                   | `{}`                                             | 
| `resources`                           | Sonarqube Pod resource requests & limits                                                                                    | `{}`                                             | 
| `affinity`                            | Node / Pod affinities                                                                                                       | `{}`                                             | 
| `nodeSelector`                        | Node labels for pod assignment                                                                                              | `{}`                                             | 
| `hostAliases`                         | Aliases for IPs in /etc/hosts                                                                                               | `[]`                                             | 
| `tolerations`                         | List of node taints to tolerate                                                                                             | `[]`                                             | 
| `initSysctl.enabled`                  | Modify k8s worker to conform to system requirements                                                                         | `true`                                           | 
| `initSysctl.vmMaxMapCount`            | Set init sysctl container vm.max_map_count                                                                                  | `524288`                                         | 
| `initSysctl.fsFileMax`                | Set init sysctl container fs.file-max                                                                                       | `131072`                                         | 
| `initSysctl.nofile`                   | Set init sysctl container open file descriptors limit                                                                       | `131072`                                         | 
| `initSysctl.nproc`                    | Set init sysctl container open threads limit                                                                                | `8192 `                                          | 
| `initSysctl.image`                    | Change init sysctl container image                                                                                          | `busybox:1.32`                                   | 
| `initSysctl.securityContext`          | InitSysctl container security context                                                                                       | `{privileged: true}`                             | 
| `initSysctl.resources`                | InitSysctl container resource requests & limits                                                                             | `{}`                                             | 
| `plugins.install`                     | List of plugins to install                                                                                                  | `[]`                                             | 
| `plugins.resources`                   | Plugin Pod resource requests & limits                                                                                       | `{}`                                             | 
| `plugins.httpProxy`                   | For use behind a corporate proxy when downloading plugins                                                                   | ""                                               | 
| `plugins.httpsProxy`                  | For use behind a corporate proxy when downloading plugins                                                                   | ""                                               | 
| `podLabels`                           | Map of labels to add to the pods                                                                                            | `{}`                                             | 
| `sonarqubeFolder`                     | Directory name of Sonarqube                                                                                                 | `/opt/sonarqube`                                 | 
| `tests.enabled`                       | Flag that allows tests to be excluded from generated yaml                                                                   | true                                             | 
| `tests.image`                         | Change init test container image                                                                                            | `dduportal/bats:0.4.0`                           | 
| `extraConfig.secrets`                 | A list of `Secret`s (which must contain key/value pairs) which may be loaded into the Scanner as environment variables      | `[]`                                             | 
| `extraConfig.secrets`                 | A list of `ConfigMap`s (which must contain key/value pairs) which may be loaded into the Scanner as environment variables   | `[]`                                             | 
| `emptyDir`                            | Configuration of resources for `emptyDir`                                                                                   | `{}`                                             | 
| `terminationGracePeriodSeconds`       | Configuration of `terminationGracePeriodSeconds`                                                                            | `60`                                             |

You can also configure values for the PostgreSQL database via the Postgresql [Chart](https://hub.helm.sh/charts/bitnami/postgresql)

For overriding variables see: [Customizing the chart](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing)

### Use custom `cacerts`

In environments with air-gapped setup, especially with internal tooling (repos) and self-signed certificates it is required to provide an adequate `cacerts` which overrides the default one:

1. Create a yaml file `cacerts.yaml` with a secret that contains one or more keys to represent the certificates that you want including

   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-cacerts
   data:
     cert-1.crt: |
       xxxxxxxxxxxxxxxxxxxxxxx
   ```

2. Upload your `cacerts.yaml` to a secret in the cluster you are installing Sonarqube to.

   ```shell
   kubectl apply -f cacerts.yaml
   ```

3. Set the following values of the chart:

   ```yaml
   caCerts:
     enabled: true
     secret: my-cacerts
   ```

### Elasticsearch Settings

Since SonarQube comes bundled with an Elasticsearch instance, some [bootstrap checks](https://www.elastic.co/guide/en/elasticsearch/reference/master/bootstrap-checks.html) of the host settings are done at start.

This chart offers the option to use an initContainer in privilaged mode to automatically set certain kernel settings on the kube worker. While this can ensure proper functionality of Elasticsearch, modifying the underlying kernel settings on the Kubernetes node can impact other users. It may be best to work with your cluster administrator to either provide specific nodes with the proper kernel settings, or ensure they are set cluster wide.

To enable auto-configuration of the kube worker node, set `elasticsearch.configureNode` to `true`.  This is the default behavior, so you do not need to explicitly set this.

This will run `sysctl -w vm.max_map_count=262144` on the worker where the sonarqube pod(s) get scheduled. This needs to be set to `262144` but normally defaults to `65530`. Other kernel settings are recommended by the [docker image](https://hub.docker.com/_/sonarqube/#requirements), but the defaults work fine in most cases.

To disable worker node configuration, set `elasticsearch.configureNode` to `false`.  Note that if node configuration is not enabled, then you will likely need to also disable the Elasticsearch bootstrap checks.  These can be explicitly disabled by setting `elasticsearch.bootstrapChecks` to `false`.

### As of 7.9 Mysql is no longer supported, so it has been removed from the chart

### Extra Config

For environments where another tool, such as terraform or ansible, is used to provision infrastructure or passwords then setting databases addresses and credentials via helm becomes less than ideal. Ditto for environments where this config may be visible.

In such environments, configuration may be read, via environment variables, from Secrets and ConfigMaps.

1. Create a `ConfigMap` (or `Secret`) containing key/value pairs, as expected by Sonarqube

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: external-sonarqube-opts
    data:
      SONARQUBE_JDBC_USERNAME: foo
      SONARQUBE_JDBC_URL: jdbc:postgresql://db.example.com:5432/sonar
    ```

2. Set the following in your `values.yaml` (using the key `extraConfig.secrets` to reference `Secret`s)

    ```yaml
    extraConfig:
      configmaps:
        - external-sonarqube-opts
    ```
