{{/* Generate basic labels, .root is a dict that passed from the .Values scope, .application & .application_name is passed from the apps range */}}
{{- define "labels" }}
domain: {{ .root.global.name }}
app: {{ .application_name }}
owner: {{ required "please enter a team name" .root.global.team_name }}
env: {{ required "please enter env name" .root.global.environment }}
cluster: {{ required "please enter a cluster name" .root.global.cluster }}
{{ if .application.labels }}
{{ range $label_key,$label_val := .application.labels }}
{{ $label_key }}: {{ $label_val }}
{{ end }}
{{ if .root.global.labels }}
{{ range $label_key,$label_val := .root.global.labels }}
{{ $label_key }}: {{ $label_val }}
{{ end }}
{{ end }}
{{ end }}
{{- end }}

{{- define "annotations" }}
{{ if or (.application.annotations) (.root.annotations) }}
{{ if .application.annotations }}
{{ range $key,$val := .application.annotations }}
{{ $key }}: {{ $val }}
{{ end }}
{{ end }}
{{ if .root.global.annotations }}
{{ range $key,$val := .root.global.annotations }}
{{ $key }}: {{ $val }}
{{ end }}
{{ end }}
{{ end }}
{{- end }}