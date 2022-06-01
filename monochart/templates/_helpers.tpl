{{- define "base_name" }}
{{ printf "%s-%s-%s" .root.global.environment .root.global.name .application_name }}
{{- end }}

{{- define "renderedValues" -}}
{{- $originalValues := .Values | toYaml }}
{{- $newValuesYaml := tpl $originalValues . }}
{{- $newValues := $newValuesYaml | fromYaml }}
{{- $_ := set $ "Values" $newValues -}}
{{- end }}