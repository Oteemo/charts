{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nexus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "nexus.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create a default fully qualified name for proxy keystore secret.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "nexus.proxy-ks.name" -}}
{{- printf "%s-%s" (include "nexus.fullname" .) "proxy-ks" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*  Manage the labels for each entity  */}}
{{- define "nexus.labels" -}}
app: {{ template "nexus.name" . }}
fullname: {{ template "nexus.fullname" . }}
chart: {{ .Chart.Name }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/*
Create a fully qualified name for docker ingress.
*/}}
{{- define "nexus.ingres.docker" -}}
{{- printf "%s-%s" (include "nexus.fullname" .) "docker" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
