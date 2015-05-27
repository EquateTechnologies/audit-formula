=============
audit-formula
=============

A salt formula to configure the kernel audit framework.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
----------------

.. contents::
    :local:

``audit``
---------

Install the ``audit`` package and configuration files.

``audit.pam``
-------------

Additional states to configure PAM with existing module (optional) ::

	servername:
	  - audit.pam


or only select the appropriate pam modules to update ::

	servername:
	  - audit.pam.ssh
	  - audit.pam.login

Usage
=====

Include audit in your top file ::

    servname:
      - audit
      - audit.pam

If you need to override the default settings, create a new pillar file and
override the needed parameters, eg ::

    audit
      auditd:
         log_file: /var/log/audit/audit.log
         num_logs: 10
