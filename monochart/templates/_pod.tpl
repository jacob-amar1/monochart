{{- define "environment_variabels" }}
{{- if or (.root.global.env) (.application.env) }}
env:
{{- if .root.global.env }}
{{- range $key, $value := .root.global.env }}
 - name: {{ $key }}
   value: {{ $value | quote }}
{{- end }}
{{- end }}
{{ if .application.env }}
{{- range $key, $value := .application.env }}
 - name: {{ $key }}
   value: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "containers" }}
{{ $base_name := printf "%s-%s-%s" .root.global.environment .root.global.name .application_name }}
containers:
  - name: {{ $base_name }}
    image: "{{ .root.global.image.repository }}/{{ .application_name }}:{{ .application.image.tag }}"
    imagePullPolicy: {{ default "IfNotPresent" .application.imagePullPolicy }}
    {{- if .application.configmap }}
    volumeMounts:
    {{- range .application.configmap.config_files }}
    - name: {{ printf "%s-configmap" $base_name }}-volume
      mountPath: {{ printf "%s/%s" .mount_on .name }}
      subPath: {{ .name }}
    {{- end }}
    {{- end }}
    {{ if .application.ports }}
    ports:
    {{- range .application.ports }}
    - name: {{ .name }}
      containerPort: {{ .port }}
      protocol: {{ .protocol }}
    {{- end }}
    {{ end }}
    {{ include "environment_variabels" . | indent 4}}
    resources:
      limits:
        memory: {{ .application.resources.limits.memory }}
        cpu: {{ .application.resources.limits.cpu }}
      requests:
        cpu: {{ .application.resources.requests.cpu }}
        memory: {{ .application.resources.requests.memory }}
{{- end }}

{{- define "volumes" }}
{{ $base_name := printf "%s-%s-%s" .root.global.environment .root.global.name .application_name }}
{{- if .application.configmap }}
volumes:
- name: {{ printf "%s-configmap-volume" $base_name }}
  configMap:
    name: {{ printf "%s-configmap" $base_name }}
{{ end }}
{{- end }}