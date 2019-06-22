{% from 'audit/map.jinja' import audit with context %}

auditd-pkg:
  pkg.installed:
    - name: {{ audit.pkg }}

auditd-sysconfig:
  file.managed:
    - name: {{ audit.config }}
    - source: salt://audit/files/auditd.sysconfig
    - template: jinja
    - mode: 0640

auditd-conf:
  file.managed:
    - name: /etc/audit/auditd.conf
    - source: salt://audit/files/auditd.conf
    - template: jinja
    - mode: 0640

auditd-rules:
  file.managed:
    - name: /etc/audit/rules.d/00_audit.rules
    - source: salt://audit/files/audit.rules
    - template: jinja
    - mode: 0640

auditd-immutable:
  file.managed:
    - name: /etc/audit/rules.d/99_immutable.rules
    - source: salt://audit/files/immutable.rules
    - mode: 0640

audispd-conf:
  file.managed:
    - name: /etc/audisp/audispd.conf
    - source: salt://audit/files/audispd.conf
    - template: jinja
    - mode: 0640

auditd-service:
  service.running:
    - name: auditd
    - require:
        - pkg: auditd-pkg
        - file: auditd-sysconfig
        - file: auditd-conf
        - file: auditd-rules
        - file: auditd-immutable
        - file: audispd-conf
    - watch:
        - file: auditd-sysconfig
        - file: auditd-conf
        - file: auditd-rules
        - file: auditd-immutable
        - file: audispd-conf
