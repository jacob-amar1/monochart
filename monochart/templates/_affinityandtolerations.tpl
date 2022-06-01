{{- define "affinityandtolerations" }}
{{ if .application.affinity }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
            - key: {{ .application.affinity.key }}
              operator: In
              values:
                - {{ .application.affinity.value }}
tolerations:
  - key: "{{ .application.toleration.key }}"
    value: "{{ .application.toleration.key }}"
    operator: "Equal"
    effect: "NoSchedule"
{{ else }}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
            - key: {{ .root.global.affinity.key }}
              operator: In
              values:
                - {{ .root.global.affinity.value }}
tolerations:
  - key: "{{ .root.global.toleration.key }}"
    value: "{{ .root.global.toleration.key }}"
    operator: "Equal"
    effect: "NoSchedule"
{{ end }}
{{- end }}